import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/interfaces/player/playback_interface.dart';
import 'package:pyro_music/core/base/interfaces/player/player_interface.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';

/// 播放服务实现 - 使用 just_audio
class PlaybackServiceImpl extends PlayerService {
  final AudioPlayer _player = AudioPlayer();
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);
  final ServiceRegistry _serviceRegistry = ServiceRegistry();
  late final Isar _isar;

  TrackSourceManager? _trackSourceManager;
  
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

  PlaybackServiceImpl() {
    _isar = GetIt.instance<Isar>();
    _initStreams();
  }

  void _initStreams() {
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
    });

    _positionSubscription = _player.positionStream.listen((pos) {
      _positionController.add(pos);
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

    _currentIndexSubscription = _player.currentIndexStream.listen((index) {
      if (index != null && index >= 0 && index < _playlist.length) {
        final tag = _playlist.children[index].sequence.first.tag;
        if (tag is String) {
          _currentTrackId = tag;
          _currentTrackController.add(_currentTrackId);
        }
      }
    });
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

  @override
  Future<void> pause() async => await _player.pause();

  @override
  Future<void> resume() async => await _player.play();

  @override
  Future<void> stop() async => await _player.stop();

  @override
  Future<void> seekTo(Duration position) async => await _player.seek(position);

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
  Future<List<String>> getHistory() async => []; // TODO: Implement history

  @override
  Future<void> clearHistory() async {}

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
}
