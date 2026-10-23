import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/services/equalizer_service.dart';
import 'package:pyro_music/core/services/desktop_service.dart';

/// 播放服务实现 - 使用 just_audio
class PlaybackServiceImpl extends PlayerService {
  final AndroidEqualizer _equalizer = AndroidEqualizer();
  late final AudioPlayer _player;
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);
  final ServiceRegistry _serviceRegistry = ServiceRegistry();
  late final Isar _isar;

  TrackSourceManager? _trackSourceManager;
  EqualizerService? _equalizerService;
  
  String? _currentTrackId;
  PlaybackState _currentState = PlaybackState.none;

  // Streams
  final _positionController = StreamController<Duration>.broadcast();
  final _bufferedPositionController = StreamController<Duration>.broadcast();
  final _durationController = StreamController<Duration>.broadcast();
  final _playbackStateController = StreamController<PlaybackState>.broadcast();
  final _currentTrackController = StreamController<String?>.broadcast();
  final _volumeController = StreamController<double>.broadcast();
  final _repeatModeController = StreamController<RepeatMode>.broadcast();
  final _shuffleModeController = StreamController<bool>.broadcast();

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _volumeSubscription;
  StreamSubscription? _currentIndexSubscription;
  StreamSubscription? _equalizerEnabledSubscription;
  StreamSubscription? _equalizerBandsSubscription;

  PlaybackServiceImpl() {
    _isar = GetIt.instance<Isar>();
    _player = AudioPlayer(
      audioPipeline: defaultTargetPlatform == TargetPlatform.android 
          ? AudioPipeline(androidAudioEffects: [_equalizer])
          : null,
    );
    _initPlayer();
    _initStreams();
    _initEqualizer();
  }

  void _initPlayer() async {
    // 尝试添加均衡器效果 (Android)
    try {
      await _player.setAudioSource(_playlist, preload: false);
    } catch (e) {
      debugPrint('Error initializing player: $e');
    }
  }

  void _initEqualizer() {
    _equalizerService = _serviceRegistry.getService<EqualizerService>('equalizer_service');
    if (_equalizerService != null) {
      // 初始状态
      _applyEqualizerEnabled(_equalizerService!.isEnabled);
      _applyEqualizerBands(_equalizerService!.bandLevels);

      // 监听变化
      _equalizerEnabledSubscription = _equalizerService!.enabledStream.listen((enabled) {
        _applyEqualizerEnabled(enabled);
      });

      _equalizerBandsSubscription = _equalizerService!.bandsStream.listen((bands) {
        _applyEqualizerBands(bands);
      });
    }
  }

  void _applyEqualizerEnabled(bool enabled) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _equalizer.setEnabled(enabled);
    }
  }

  Future<void> _applyEqualizerBands(List<double> levels) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final parameters = await _equalizer.parameters;
      for (int i = 0; i < levels.length && i < parameters.bands.length; i++) {
        parameters.bands[i].setGain(levels[i]);
      }
    }
  }

  void _initStreams() {
    final desktopService = _serviceRegistry.getService<DesktopService>('desktop_service');

    _playerStateSubscription = _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering) {
        _currentState = PlaybackState.buffering;
      } else if (state.playing) {
        _currentState = PlaybackState.playing;
      } else if (state.processingState == ProcessingState.ready) {
        _currentState = PlaybackState.paused;
      } else if (state.processingState == ProcessingState.completed) {
        _currentState = PlaybackState.completed;
      } else {
        _currentState = PlaybackState.none;
      }
      _playbackStateController.add(_currentState);
      
      // Update desktop status
      desktopService?.setTaskbarStatus(state.playing);
      desktopService?.updatePlaybackState(state.playing);
    });

    _positionSubscription = _player.positionStream.listen((pos) {
      _positionController.add(pos);
      
      // Update desktop taskbar progress
      final dur = _player.duration;
      if (dur != null && dur.inMilliseconds > 0) {
        desktopService?.updateTaskbarProgress(pos.inMilliseconds / dur.inMilliseconds);
      }
    });

    _bufferedPositionSubscription = _player.bufferedPositionStream.listen((pos) {
      _bufferedPositionController.add(pos);
    });

    _durationSubscription = _player.durationStream.listen((dur) {
      if (dur != null) {
        _durationController.add(dur);
      }
    });

    _volumeSubscription = _player.volumeStream.listen((vol) {
      _volumeController.add(vol);
    });

    _currentIndexSubscription = _player.currentIndexStream.listen((index) async {
      if (index != null && index >= 0 && index < _playlist.length) {
        final tag = _playlist.children[index].sequence.first.tag;
        if (tag is String) {
          _currentTrackId = tag;
          _currentTrackController.add(_currentTrackId);
          _updatePlayStats(tag);

          // Show desktop notification
           if (desktopService != null) {
             final track = await _isar.trackEntitys.filter().trackIdEqualTo(tag).findFirst();
             if (track != null) {
               desktopService.showNotification(
                 track.name,
                 track.artistNames?.join(', ') ?? 'Unknown Artist',
               );
               desktopService.updateMetadata(
                 track.name,
                 track.artistNames?.join(', ') ?? 'Unknown Artist',
                 album: track.albumName,
                 imageUrl: track.imageUrl,
               );
             }
           }
        }
      }
    });
  }

  Future<void> _updatePlayStats(String trackId) async {
    try {
      final statsService = _serviceRegistry.getService<StatsService>('play_stats_service');
      if (statsService != null) {
        final entity = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
        if (entity != null) {
          final trackModel = _entityToModel(entity);
          await statsService.recordPlay(trackModel, isComplete: true);
        }
      }
    } catch (e) {
      debugPrint('Error updating play stats: $e');
    }
  }

  @override
  String get serviceId => 'native_player';

  @override
  String get serviceName => 'Native Player';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => 'native';

  @override
  PlaybackInterface get playback => _PlaybackInterfaceWrapper(this);

  @override
  String? get currentTrackId => _currentTrackId;

  @override
  Duration get position => _player.position;

  @override
  Duration get bufferedPosition => _player.bufferedPosition;

  @override
  Duration get duration => _player.duration ?? Duration.zero;

  @override
  double get volume => _player.volume;

  @override
  PlaybackState get state => _currentState;

  @override
  RepeatMode get repeatMode {
    switch (_player.loopMode) {
      case LoopMode.off:
        return RepeatMode.off;
      case LoopMode.one:
        return RepeatMode.one;
      case LoopMode.all:
        return RepeatMode.all;
    }
  }

  @override
  bool get shuffleMode => _player.shuffleModeEnabled;

  @override
  Future<void> initialize() async {
    _trackSourceManager = _serviceRegistry.getService<TrackSourceManager>('track_source_manager');
    await _player.setAudioSource(_playlist);
  }

  @override
  Future<void> play({required String trackId, String? sourceId, String? sourceName}) async {
    // 检查是否已经在队列中
    int index = -1;
    for (int i = 0; i < _playlist.length; i++) {
      if (_playlist.children[i].sequence.first.tag == trackId) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      // 不在队列中，添加并播放
      await addTrack(trackId);
      index = _playlist.length - 1;
    }

    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  Future<void> playTrack(String trackId) async {
    final source = await _createAudioSource(trackId);
    await _playlist.clear();
    await _playlist.add(source);
    await _player.setAudioSource(_playlist);
    await _player.play();
  }

  Future<void> playTracks(List<String> trackIds, {int initialIndex = 0}) async {
    await _playlist.clear();
    final sources = <AudioSource>[];
    for (final id in trackIds) {
      sources.add(await _createAudioSource(id));
    }
    await _playlist.addAll(sources);
    await _player.setAudioSource(_playlist, initialIndex: initialIndex);
    await _player.play();
  }

  @override
  Future<void> pause() async => await _player.pause();

  @override
  Future<void> resume() async => await _player.play();

  @override
  Future<void> stop() async => await _player.stop();

  @override
  Future<void> seekTo(Duration position) async => await _player.seek(position);

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> next() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  @override
  Future<void> previous() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  @override
  Future<void> setVolume(double volume) async => await _player.setVolume(volume);

  @override
  Future<Duration> getPosition() async => position;

  @override
  Future<Duration> getDuration() async => duration;

  @override
  Future<bool> isPlaying() async => _player.playing;

  @override
  Future<String?> getCurrentTrackId() async => _currentTrackId;

  @override
  Future<void> setPlaybackSpeed(double speed) async => await _player.setSpeed(speed);

  @override
  Future<void> setRepeatMode(RepeatMode mode) async {
    switch (mode) {
      case RepeatMode.off:
        await _player.setLoopMode(LoopMode.off);
        break;
      case RepeatMode.one:
        await _player.setLoopMode(LoopMode.one);
        break;
      case RepeatMode.all:
        await _player.setLoopMode(LoopMode.all);
        break;
    }
    _repeatModeController.add(mode);
  }

  @override
  Future<void> setShuffleMode(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
    _shuffleModeController.add(enabled);
  }

  // QueueInterface implementation
  @override
  Future<void> addTrack(String trackId) async {
    final source = await _createAudioSource(trackId);
    await _playlist.add(source);
  }

  @override
  Future<void> addTracks(List<String> trackIds) async {
    final sources = <AudioSource>[];
    for (final id in trackIds) {
      sources.add(await _createAudioSource(id));
    }
    await _playlist.addAll(sources);
  }

  @override
  Future<void> addTracksNext(List<String> trackIds) async {
    final currentIndex = _player.currentIndex ?? -1;
    final insertIndex = currentIndex + 1;
    final sources = <AudioSource>[];
    for (final id in trackIds) {
      sources.add(await _createAudioSource(id));
    }
    
    if (insertIndex >= 0 && insertIndex <= _playlist.length) {
      await _playlist.insertAll(insertIndex, sources);
    } else {
      await _playlist.addAll(sources);
    }
  }

  @override
  Future<void> removeTrack(String trackId) async {
    for (int i = 0; i < _playlist.length; i++) {
      if (_playlist.children[i].sequence.first.tag == trackId) {
        await _playlist.removeAt(i);
        break;
      }
    }
  }

  @override
  Future<void> removeTrackAt(int index) async {
    if (index >= 0 && index < _playlist.length) {
      await _playlist.removeAt(index);
    }
  }

  @override
  Future<void> clearQueue() async {
    await _playlist.clear();
  }

  @override
  Future<List<String>> getQueue() async {
    return _playlist.children.map((e) => e.sequence.first.tag as String).toList();
  }

  @override
  Future<int> getCurrentIndex() async {
    return _player.currentIndex ?? -1;
  }

  @override
  Future<void> moveTrack(int oldIndex, int newIndex) async {
    await _playlist.move(oldIndex, newIndex);
  }

  @override
  Future<void> skipToIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      await _player.seek(Duration.zero, index: index);
    }
  }

  @override
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0}) async {
    await _playlist.clear();
    await addTracks(trackIds);
    if (startIndex >= 0 && startIndex < trackIds.length) {
      await _player.seek(Duration.zero, index: startIndex);
    }
  }

  @override
  Future<List<String>> getHistory() async {
    final statsService = _serviceRegistry.getService<StatsService>('play_stats_service');
    if (statsService == null) return [];
    
    final recentPlays = await statsService.getRecentPlays(limit: 50);
    return recentPlays.map((e) => e.track.id).toList();
  }

  @override
  Future<void> clearHistory() async {
    await _isar.writeTxn(() async {
      final entities = await _isar.trackEntitys
          .filter()
          .lastPlayedAtIsNotNull()
          .findAll();
      
      for (final entity in entities) {
        entity.lastPlayedAt = null;
        await _isar.trackEntitys.put(entity);
      }
    });
  }

  // PlayerService implementation
  @override
  Future<List<String>> getAvailableDevices() async => [];

  @override
  Future<bool> transferPlayback(String deviceId) async => false;

  @override
  Future<TrackInterface?> getCurrentTrack() async {
    if (_currentTrackId == null) return null;
    
    // 从 Isar 获取轨道详情
    final entity = await _isar.trackEntitys
        .filter()
        .trackIdEqualTo(_currentTrackId!)
        .findFirst();
        
    if (entity == null) return null;
    
    return _entityToModel(entity);
  }

  TrackModel _entityToModel(TrackEntity entity) {
    return TrackModel(
      id: entity.trackId,
      platform: entity.platform,
      name: entity.name,
      imageUrl: entity.imageUrl,
      artistIds: entity.artistIds ?? [],
      artistNames: entity.artistNames ?? [],
      albumId: entity.albumId,
      albumName: entity.albumName,
      durationMs: entity.durationMs,
      isPlayable: entity.isPlayable,
      previewUrl: entity.previewUrl,
      localPath: entity.localPath,
      isFavorite: entity.isFavorite,
    );
  }

  Future<AudioSource> _createAudioSource(String trackId) async {
    // 1. 获取轨道详情
    final entity = await _isar.trackEntitys
        .filter()
        .trackIdEqualTo(trackId)
        .findFirst();

    if (entity == null) {
      throw Exception('Track not found in database: $trackId');
    }

    final track = _entityToModel(entity);

    // 2. 获取音源 URL
    _trackSourceManager ??= _serviceRegistry.getService<TrackSourceManager>('track_source_manager');

    String? url;
    try {
      final sourcedTrack = await _trackSourceManager!.fetchFromTrack(track: track);
      url = sourcedTrack.sourceInfo.url;
    } catch (e) {
      debugPrint('Error fetching track source: $e');
    }

    // 如果获取失败或 URL 为空，尝试使用预览 URL
    url ??= track.previewUrl;

    if (url == null || url.isEmpty) {
      // 最后的兜底：抛出异常，而不是使用测试音频
      throw Exception('Failed to get playable URL for track: $trackId');
    }

    // 3. 创建 AudioSource
    if (url.startsWith('file://')) {
      return AudioSource.file(
        url.replaceFirst('file://', ''),
        tag: trackId,
      );
    }
    
    return AudioSource.uri(
      Uri.parse(url),
      tag: trackId, // 简单使用 ID 作为 tag，或者封装更复杂的 Metadata
    );
  }

  @override
  Future<void> dispose() async {
    await _playerStateSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _bufferedPositionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _volumeSubscription?.cancel();
    await _currentIndexSubscription?.cancel();
    await _equalizerEnabledSubscription?.cancel();
    await _equalizerBandsSubscription?.cancel();
    await _player.dispose();
    
    await _positionController.close();
    await _bufferedPositionController.close();
    await _durationController.close();
    await _playbackStateController.close();
    await _currentTrackController.close();
    await _volumeController.close();
    await _repeatModeController.close();
    await _shuffleModeController.close();
    
    await super.dispose();
  }

  @override
  Future<bool> isAvailable() async => true;

  @override
  Map<String, dynamic> getConfig() => {};

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {}

  @override
  List<Type> getDependencies() => [];

  @override
  ServiceStatus getStatus() => ServiceStatus.available;
}

class _PlaybackInterfaceWrapper implements PlaybackInterface {
  final PlaybackServiceImpl _service;

  _PlaybackInterfaceWrapper(this._service);

  @override
  Stream<Duration> get positionStream => _service._positionController.stream;

  @override
  Duration get position => _service.position;

  @override
  Stream<Duration> get bufferedPositionStream => _service._bufferedPositionController.stream;

  @override
  Stream<Duration> get durationStream => _service._durationController.stream;

  @override
  Stream<PlaybackState> get playbackStateStream => _service._playbackStateController.stream;

  @override
  Stream<String?> get currentTrackStream => _service._currentTrackController.stream;

  @override
  Stream<double> get volumeStream => _service._volumeController.stream;

  @override
  Stream<RepeatMode> get repeatModeStream => _service._repeatModeController.stream;

  @override
  Stream<bool> get shuffleModeStream => _service._shuffleModeController.stream;

  @override
  PlaybackState get currentState => _service.state;

  @override
  double get volume => _service.volume;

  @override
  RepeatMode get repeatMode => _service.repeatMode;

  @override
  bool get shuffleMode => _service.shuffleMode;

  @override
  Duration get duration => _service.duration;
}
