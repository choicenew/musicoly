import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/interfaces/player/player_interface.dart';

import '../../../core/base/services/base_service.dart';
import '../../../core/base/services/playback_service.dart';
import '../../../core/base/interfaces/player/playback_interface.dart';
import '../../../core/services/service_registry.dart';
import '../../../core/platform/platform_registry.dart';

/// 播放控制服务实现 - 管理播放状态和控制
///
/// 提供统一的播放控制接口，整合不同平台的播放控制功能
class PlaybackServiceImpl extends BaseService implements PlaybackService {
  /// 服务注册表实例
  final ServiceRegistry _serviceRegistry = ServiceRegistry();

  /// 平台注册表实例
  final PlatformRegistry _platformRegistry = PlatformRegistry();

  /// 当前活跃的播放控制服务
  PlaybackService? _activePlaybackService;

  /// 播放位置控制器
  final _positionController = StreamController<Duration>.broadcast();

  /// 缓冲位置控制器
  final _bufferedPositionController = StreamController<Duration>.broadcast();

  /// 总时长控制器
  final _durationController = StreamController<Duration>.broadcast();

  /// 播放状态控制器
  final _playbackStateController = StreamController<PlaybackState>.broadcast();

  /// 当前曲目控制器
  final _currentTrackController = StreamController<String?>.broadcast();

  /// 音量控制器
  final _volumeController = StreamController<double>.broadcast();

  /// 当前播放状态
  PlaybackState _currentState = PlaybackState.none;

  /// 当前音量
  double _volume = 1.0;

  /// 当前播放位置
  Duration _position = Duration.zero;

  /// 当前缓冲位置
  Duration _bufferedPosition = Duration.zero;

  /// 当前总时长
  Duration _duration = Duration.zero;

  /// 当前曲目ID
  String? _currentTrackId;

  /// 当前重复模式
  RepeatMode _repeatMode = RepeatMode.off;

  /// 当前随机播放模式
  bool _shuffleMode = false;

  /// 重复模式控制器
  final _repeatModeController = StreamController<RepeatMode>.broadcast();

  /// 随机播放模式控制器
  final _shuffleModeController = StreamController<bool>.broadcast();

  /// 定时器，用于模拟播放进度
  Timer? _progressTimer;

  /// 构造函数
  PlaybackServiceImpl() {
    _initializeActiveService();
    _setupProgressTimer();
  }

  /// 初始化活跃服务
  Future<void> _initializeActiveService() async {
    final platformId = _platformRegistry.activePlatformId;
    if (platformId.isNotEmpty) {
      _activePlaybackService =
          _serviceRegistry.getService<PlaybackService>(platformId);
      if (_activePlaybackService != null) {
        debugPrint('已设置活跃播放控制服务: $platformId');
      }
    }
  }

  /// 设置进度定时器
  void _setupProgressTimer() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_currentState == PlaybackState.playing) {
        // 模拟播放进度
        _position += const Duration(milliseconds: 500);
        _positionController.add(_position);

        // 模拟缓冲进度
        if (_bufferedPosition < _duration &&
            _bufferedPosition < _position + const Duration(seconds: 30)) {
          _bufferedPosition = _position + const Duration(seconds: 30);
          if (_bufferedPosition > _duration) {
            _bufferedPosition = _duration;
          }
          _bufferedPositionController.add(_bufferedPosition);
        }

        // 检查是否播放完成
        if (_position >= _duration && _duration > Duration.zero) {
          _currentState = PlaybackState.completed;
          _playbackStateController.add(_currentState);
          timer.cancel();
        }
      }
    });
  }

  @override
  String get serviceId => 'playback_service';

  @override
  String get serviceName => '播放控制服务';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // 不依赖特定平台

  @override
  Future<void> initialize() async {
    await _initializeActiveService();
  }

  @override
  Future<void> playTrack(String trackId) async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.playTrack(trackId);
    }

    // 更新播放状态
    _currentTrackId = trackId;
    _currentTrackController.add(trackId);
    _currentState = PlaybackState.playing;
    _playbackStateController.add(_currentState);

    // 重置播放位置
    _position = Duration.zero;
    _positionController.add(_position);

    // 设置模拟的总时长
    _duration = const Duration(minutes: 3, seconds: 30); // 默认3分30秒
    _durationController.add(_duration);

    // 设置模拟的缓冲位置
    _bufferedPosition = const Duration(seconds: 10);
    _bufferedPositionController.add(_bufferedPosition);

    // 重新设置进度定时器
    _setupProgressTimer();

    debugPrint('开始播放曲目: $trackId');
  }

  @override
  Future<void> pausePlayback() async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.pausePlayback();
    }

    // 更新播放状态
    _currentState = PlaybackState.paused;
    _playbackStateController.add(_currentState);
    debugPrint('暂停播放');
  }

  @override
  Future<void> resumePlayback() async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.resumePlayback();
    }

    // 更新播放状态
    _currentState = PlaybackState.playing;
    _playbackStateController.add(_currentState);
    debugPrint('恢复播放');
  }

  @override
  Future<void> seekToPosition(int positionMs) async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.seekToPosition(positionMs);
    }

    // 更新播放位置
    _position = Duration(milliseconds: positionMs);
    _positionController.add(_position);
    debugPrint('跳转到位置: ${positionMs}ms');
  }

  @override
  Future<void> setVolume(double volume) async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.setVolume(volume);
    }

    // 更新音量
    _volume = volume;
    _volumeController.add(_volume);
    debugPrint('设置音量: $volume');
  }

  @override
  Future<Map<String, dynamic>> getPlaybackState() async {
    if (_activePlaybackService != null) {
      return _activePlaybackService!.getPlaybackState();
    }

    // 返回当前播放状态
    return {
      'state': _currentState.toString(),
      'position': _position.inMilliseconds,
      'bufferedPosition': _bufferedPosition.inMilliseconds,
      'duration': _duration.inMilliseconds,
      'volume': _volume,
      'trackId': _currentTrackId,
      'repeatMode': _repeatMode.toString(),
      'shuffleMode': _shuffleMode,
    };
  }

  @override
  Future<void> nextTrack() async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.nextTrack();
    }

    // 模拟切换到下一曲
    final nextTrackId = 'track-${DateTime.now().millisecondsSinceEpoch}';
    await playTrack(nextTrackId);
    debugPrint('切换到下一曲: $nextTrackId');
  }

  @override
  Future<void> previousTrack() async {
    if (_activePlaybackService != null) {
      await _activePlaybackService!.previousTrack();
    }

    // 模拟切换到上一曲
    final prevTrackId = 'track-${DateTime.now().millisecondsSinceEpoch - 1000}';
    await playTrack(prevTrackId);
    debugPrint('切换到上一曲: $prevTrackId');
  }

  /// 获取播放位置流
  Stream<Duration> get positionStream => _positionController.stream;

  /// 获取缓冲位置流
  Stream<Duration> get bufferedPositionStream =>
      _bufferedPositionController.stream;

  /// 获取总时长流
  Stream<Duration> get durationStream => _durationController.stream;

  /// 获取播放状态流
  Stream<PlaybackState> get playbackStateStream =>
      _playbackStateController.stream;

  /// 获取当前曲目流
  Stream<String?> get currentTrackStream => _currentTrackController.stream;

  /// 获取音量流
  Stream<double> get volumeStream => _volumeController.stream;

  /// 获取重复模式流
  Stream<RepeatMode> get repeatModeStream => _repeatModeController.stream;

  /// 获取随机播放模式流
  Stream<bool> get shuffleModeStream => _shuffleModeController.stream;

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode) async {
    if (_activePlaybackService != null) {
      // 如果有活跃的服务，调用其方法
      // 这里需要在PlaybackService接口中添加相应的方法
    }

    // 更新重复模式
    _repeatMode = mode;
    _repeatModeController.add(mode);
    debugPrint('设置重复模式: $mode');
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    if (_activePlaybackService != null) {
      // 如果有活跃的服务，调用其方法
      // 这里需要在PlaybackService接口中添加相应的方法
    }

    // 更新随机播放模式
    _shuffleMode = enabled;
    _shuffleModeController.add(enabled);
    debugPrint('设置随机播放模式: $enabled');
  }

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
    _progressTimer?.cancel();
    _positionController.close();
    _bufferedPositionController.close();
    _durationController.close();
    _playbackStateController.close();
    _currentTrackController.close();
    _volumeController.close();
    _repeatModeController.close();
    _shuffleModeController.close();
    debugPrint('释放播放控制服务资源');
  }
}
