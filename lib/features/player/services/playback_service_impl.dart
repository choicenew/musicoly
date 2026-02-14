import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/services/playback_service.dart';
import 'package:pyro_music/core/base/interfaces/player/playback_interface.dart';
import 'package:pyro_music/core/base/interfaces/player/player_interface.dart';
import 'package:pyro_music/core/base/interfaces/player/queue_interface.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/services/service_registry.dart';

/// 播放服务实现 - 使用 just_audio
class PlaybackServiceImpl extends PlaybackService {
  final AudioPlayer _player = AudioPlayer();
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);
  final ServiceRegistry _serviceRegistry = ServiceRegistry();

  PlaybackService? _activePlaybackService;
  QueueInterface? _queueService;
  TrackSourceManager? _trackSourceManager;

  // 状态流控制器
  final _positionController = StreamController<Duration>.broadcast();
  final _bufferedPositionController = StreamController<Duration>.broadcast();
  final _durationController = StreamController<Duration>.broadcast();
  final _playbackStateController = StreamController<PlaybackState>.broadcast();
  final _currentTrackController = StreamController<String?>.broadcast();
  final _volumeController = StreamController<double>.broadcast();
  final _repeatModeController = StreamController<RepeatMode>.broadcast();
  final _shuffleModeController = StreamController<bool>.broadcast();

  // 内部状态
  PlaybackState _currentState = PlaybackState.none;
  String? _currentTrackId;
  double _volume = 1.0;
  RepeatMode _repeatMode = RepeatMode.off;
  bool _shuffleMode = false;

  // 订阅
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _volumeSubscription;
  StreamSubscription? _currentIndexSubscription;

  PlaybackServiceImpl() {
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
      _volume = vol;
      _volumeController.add(vol);
    });

    _currentIndexSubscription = _player.currentIndexStream.listen((index) async {
      if (index != null && _queueService != null) {
        final queue = await _queueService!.getQueue();
        if (index >= 0 && index < queue.length) {
          _currentTrackId = queue[index];
          _currentTrackController.add(_currentTrackId);
        }
      }
    });
  }

  Future<void> _initializeActiveService() async {
    // 可以在这里根据平台初始化活跃服务
  }

  @override
  String get serviceId => 'playback_service';

  @override
  String get serviceName => '播放服务';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {
    await _initializeActiveService();

    _queueService = _serviceRegistry.getService<QueueInterface>('queue_service');
    _trackSourceManager =
        _serviceRegistry.getService<TrackSourceManager>('track_source_manager');

    await _player.setAudioSource(_playlist);
  }

  @override
  Future<void> playTrack(String trackId) async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.playTrack(trackId);
      return;
    }

    if (_queueService == null) {
      debugPrint('错误: QueueService 未初始化');
      return;
    }

    final queue = await _queueService!.getQueue();
    final index = queue.indexOf(trackId);

    if (index == -1) {
      debugPrint('错误: 曲目 $trackId 不在队列中');
      return;
    }

    try {
      await _syncPlaylistWithQueue(queue);

      await _player.seek(Duration.zero, index: index);
      await _player.play();

      _currentTrackId = trackId;
      _currentTrackController.add(trackId);
      debugPrint('开始播放队列索引 $index 的曲目: $trackId');
    } catch (e) {
      debugPrint('播放失败: $e');
      _currentState = PlaybackState.error;
      _playbackStateController.add(_currentState);
    }
  }

  Future<void> _syncPlaylistWithQueue(List<String> trackIds) async {
    if (_playlist.length != trackIds.length) {
      await _playlist.clear();
      final sources = <AudioSource>[];
      for (final id in trackIds) {
        sources.add(await _createAudioSource(id));
      }
      await _playlist.addAll(sources);
      debugPrint('已同步播放列表，共 ${trackIds.length} 首曲目');
    }
  }

  Future<AudioSource> _createAudioSource(String trackId) async {
    // 这里需要获取 TrackInterface，目前由于解耦，我们可能需要通过 TrackSourceManager 获取
    // 暂时使用占位逻辑，实际应从 MetadataService 或类似服务获取
    
    // 兜底方案：使用测试音频
    return AudioSource.uri(
      Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
      tag: trackId,
    );
  }

  @override
  Future<void> pausePlayback() async {
    await _player.pause();
    debugPrint('暂停播放');
  }

  @override
  Future<void> resumePlayback() async {
    await _player.play();
    debugPrint('恢复播放');
  }

  @override
  Future<void> stopPlayback() async {
    await _player.stop();
    debugPrint('停止播放');
  }

  @override
  Future<void> seekTo(Duration position) async {
    await _player.seek(position);
    debugPrint('跳转到位置: $position');
  }

  @override
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
    debugPrint('切换到下一首');
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
    debugPrint('切换到上一首');
  }

  @override
  Future<void> setRepeatMode(RepeatMode mode) async {
    _repeatMode = mode;
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
    debugPrint('设置重复模式: $mode');
  }

  @override
  Future<void> setShuffleMode(bool enabled) async {
    _shuffleMode = enabled;
    await _player.setShuffleModeEnabled(enabled);
    _shuffleModeController.add(enabled);
    debugPrint('设置随机播放: $enabled');
  }

  @override
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
    _volume = volume;
    _volumeController.add(volume);
    debugPrint('设置音量: $volume');
  }

  @override
  Stream<Duration> get positionStream => _positionController.stream;

  @override
  Stream<Duration> get bufferedPositionStream => _bufferedPositionController.stream;

  @override
  Stream<Duration> get durationStream => _durationController.stream;

  @override
  Stream<PlaybackState> get playbackStateStream => _playbackStateController.stream;

  @override
  Stream<String?> get currentTrackStream => _currentTrackController.stream;

  @override
  Stream<double> get volumeStream => _volumeController.stream;

  @override
  Stream<RepeatMode> get repeatModeStream => _repeatModeController.stream;

  @override
  Stream<bool> get shuffleModeStream => _shuffleModeController.stream;

  @override
  Future<bool> isAvailable() async {
    return true;
  }

  @override
  Map<String, dynamic> getConfig() {
    return {
      'autoPlay': true,
      'preloadNext': true,
      'gaplessPlayback': true,
      'crossfade': true,
      'crossfadeDuration': 3000,
      'replayGain': true,
    };
  }

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {
    debugPrint('更新播放控制服务配置: $config');
  }

  @override
  List<Type> getDependencies() {
    return [];
  }

  @override
  ServiceStatus getStatus() {
    return ServiceStatus.available;
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
}
