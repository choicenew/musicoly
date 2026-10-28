import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/features/player/services/player_service.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';
import 'package:pyro_music/core/services/desktop_service.dart';
import 'package:pyro_music/core/services/scrobbler_manager.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';

/// 播放器服务实现 - 整合多平台播放功能
///
/// 提供统一的播放器接口，整合Spotify和YouTube Music等平台的播放功能
class PlayerServiceImpl extends PlayerService {
  /// 服务注册表实例
  final ServiceRegistry _serviceRegistry = ServiceRegistry();

  /// 平台注册表实例
  final PlatformRegistry _platformRegistry = PlatformRegistry();

  /// 当前活跃的播放器服务
  PlayerService? _activePlayerService; // Remove final

  /// 播放接口实现
  final PlaybackInterfaceImpl _playback = PlaybackInterfaceImpl();

  /// 构造函数
  PlayerServiceImpl() {
    // Remove initialization from constructor
    _initializeActiveService();
  }

  /// 初始化活跃服务
  Future<void> _initializeActiveService() async {
    final platformId = _platformRegistry.activePlatformId;
    if (platformId.isNotEmpty) {
      final service = _serviceRegistry.getService<PlayerService>(platformId);
      if (service != null && service != _activePlayerService) {
        _activePlayerService = service;
        _playback.setSource(service.playback);
        debugPrint('已设置活跃播放器服务: $platformId');
        
        // 设置外部集成（桌面端 & 回传服务）
        _setupExternalIntegrations();
      }
    }
  }

  void _setupExternalIntegrations() {
    final desktopService = _serviceRegistry.getService<DesktopService>('desktop_service');
    final scrobblerManager = _serviceRegistry.getService<ScrobblerManager>('scrobbler_manager');

    String? lastTrackId;
    bool scrobbled = false;

    // 监听切歌
    _playback.currentTrackStream.listen((trackId) async {
      if (trackId == null) {
        desktopService?.updatePlaybackState(false);
        return;
      }
      if (trackId == lastTrackId) return;

      lastTrackId = trackId;
      scrobbled = false;

      final isar = GetIt.instance<Isar>();
      final track = await isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
      if (track != null) {
        final trackModel = track.toModel();
        
        // 1. 通知 Scrobbler
        if (scrobblerManager != null) {
          await scrobblerManager.notifyNowPlaying(trackModel);
        }

        // 2. 更新桌面端元数据
        if (desktopService != null) {
          desktopService.updateMetadata(
            trackModel.name,
            trackModel.artistNames.join(", "),
            album: trackModel.albumName,
            imageUrl: trackModel.imageUrl,
          );
          
          // 发送通知
          await desktopService.showNotification(
            trackModel.name,
            trackModel.artistNames.join(", "),
            imagePath: trackModel.imageUrl,
          );
        }
      }
    });

    // 监听播放状态
    _playback.playbackStateStream.listen((state) {
      if (desktopService != null) {
        final isPlaying = state == PlaybackState.playing;
        desktopService.updatePlaybackState(isPlaying);
        desktopService.setTaskbarStatus(isPlaying);
      }
    });

    // 监听进度（用于进度条和 Scrobble）
    _playback.positionStream.listen((pos) async {
      final duration = _playback.duration;
      
      // 更新任务栏进度
      if (desktopService != null && duration.inMilliseconds > 0) {
        desktopService.updateTaskbarProgress(pos.inMilliseconds / duration.inMilliseconds);
      }

      // Scrobble 逻辑
      if (scrobblerManager == null || scrobbled || lastTrackId == null) return;
      if (duration.inSeconds < 30) return; // 歌曲太短不记录

      // Scrobble 条件: 50% 或者 4 分钟 (240秒)
      final scrobbleThreshold = duration.inSeconds > 480 ? 240 : duration.inSeconds ~/ 2;

      if (pos.inSeconds >= scrobbleThreshold) {
        scrobbled = true;
        final isar = GetIt.instance<Isar>();
        final track = await isar.trackEntitys
            .filter()
            .trackIdEqualTo(lastTrackId!)
            .findFirst();
        if (track != null) {
          await scrobblerManager.notifyScrobble(
            track.toModel(),
            duration: pos.inSeconds,
            isComplete: false,
          );
        }
      }
    });
  }

  @override
  String get serviceId => 'player_service';

  @override
  String get serviceName => '播放器服务';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // 不依赖特定平台

  @override
  Map<String, dynamic> getConfig() {
    return {
      'activeService': _activePlayerService?.serviceId,
    };
  }

  @override
  List<Type> getDependencies() {
    return [ServiceRegistry, PlatformRegistry];
  }

  @override
  ServiceStatus getStatus() {
    if (_activePlayerService == null) {
      return ServiceStatus.notConfigured; // Use correct enum value
    }
    return ServiceStatus.available;
  }

  // Add missing methods
  @override
  Future<void> setPlaybackSpeed(double speed) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.setPlaybackSpeed(speed);
    }
  }

  @override
  Future<void> removeTrackAt(int index) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.removeTrackAt(index);
    }
  }

  @override
  Future<bool> isAvailable() async {
    return _activePlayerService != null;
  }

  @override
  PlaybackInterface get playback => _playback;

  @override
  String? get currentTrackId => _activePlayerService?.currentTrackId;

  @override
  Duration get position => _activePlayerService?.position ?? Duration.zero;

  @override
  Duration get bufferedPosition =>
      _activePlayerService?.bufferedPosition ?? Duration.zero;

  @override
  Duration get duration => _activePlayerService?.duration ?? Duration.zero;

  @override
  double get volume => _activePlayerService?.volume ?? 1.0;

  @override
  PlaybackState get state => _activePlayerService?.state ?? PlaybackState.none;

  @override
  RepeatMode get repeatMode =>
      _activePlayerService?.repeatMode ?? RepeatMode.off;

  @override
  bool get shuffleMode => _activePlayerService?.shuffleMode ?? false;

  @override
  Future<void> initialize() async {
    await _initializeActiveService();
    if (_activePlayerService != null) {
      await _activePlayerService!.initialize();
    }
  }

  @override
  Future<void> play(
      {required String trackId, String? sourceId, String? sourceName}) async {
    if (_activePlayerService == null) {
      await _initializeActiveService();
    }

    if (_activePlayerService != null) {
      await _activePlayerService!.play(
        trackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
      );

      // 更新播放状态
      _playback.updatePlaybackState(_activePlayerService!.state);
      _playback.updateCurrentTrack(trackId);
    } else {
      debugPrint('错误: 没有可用的播放器服务');
    }
  }

  @override
  Future<void> pause() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.pause();
      _playback.updatePlaybackState(PlaybackState.paused);
    }
  }

  @override
  Future<void> resume() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.resume();
      _playback.updatePlaybackState(PlaybackState.playing);
    }
  }

  @override
  Future<void> stop() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.stop();
      _playback.updatePlaybackState(PlaybackState.none);
    }
  }

  @override
  Future<void> seekTo(Duration position) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.seekTo(position);
      _playback.updatePosition(position);
    }
  }

  @override
  Future<void> next() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.next();
      // 更新当前曲目
      final trackId = await _activePlayerService!.getCurrentTrackId();
      _playback.updateCurrentTrack(trackId);
    }
  }

  @override
  Future<void> previous() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.previous();
      // 更新当前曲目
      final trackId = await _activePlayerService!.getCurrentTrackId();
      _playback.updateCurrentTrack(trackId);
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.setVolume(volume);
      _playback.updateVolume(volume);
    }
  }

  @override
  Future<Duration> getPosition() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getPosition();
    }
    return Duration.zero;
  }

  @override
  Future<Duration> getDuration() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getDuration();
    }
    return Duration.zero;
  }

  @override
  Future<bool> isPlaying() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.isPlaying();
    }
    return false;
  }

  @override
  Future<void> dispose() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.dispose();
    }
  }

  @override
  Future<String?> getCurrentTrackId() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getCurrentTrackId();
    }
    return null;
  }

  @override
  Future<List<String>> getAvailableDevices() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getAvailableDevices();
    }
    return [];
  }

  @override
  Future<bool> transferPlayback(String deviceId) async {
    if (_activePlayerService != null) {
      return await _activePlayerService!.transferPlayback(deviceId);
    }
    return false;
  }

  @override
  Future<void> setRepeatMode(RepeatMode mode) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.setRepeatMode(mode);
      _playback.updateRepeatMode(mode);
    }
  }

  @override
  Future<void> setShuffleMode(bool enabled) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.setShuffleMode(enabled);
      _playback.updateShuffleMode(enabled);
    }
  }

  // 队列接口实现
  @override
  Future<void> addTrack(String trackId) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.addTrack(trackId);
    }
  }

  @override
  Future<void> addTracks(List<String> trackIds) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.addTracks(trackIds);
    }
  }

  @override
  Future<void> addTracksNext(List<String> trackIds) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.addTracksNext(trackIds);
    }
  }

  @override
  Future<void> removeTrack(String trackId) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.removeTrack(trackId);
    }
  }

  @override
  Future<void> clearQueue() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.clearQueue();
    }
  }

  @override
  Future<void> seek(Duration position) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.seek(position);
    }
  }

  @override
  Future<List<String>> getQueue() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getQueue();
    }
    return [];
  }



  @override
  Future<TrackInterface?> getCurrentTrack() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getCurrentTrack();
    }
    return null;
  }

  @override
  Future<int> getCurrentIndex() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getCurrentIndex();
    }
    return -1;
  }

  @override
  Future<void> moveTrack(int oldIndex, int newIndex) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.moveTrack(oldIndex, newIndex);
    }
  }

  @override
  Future<void> skipToIndex(int index) async {
    if (_activePlayerService != null) {
      await _activePlayerService!.skipToIndex(index);
      // 更新当前曲目
      final trackId = await _activePlayerService!.getCurrentTrackId();
      _playback.updateCurrentTrack(trackId);
    }
  }

  @override
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0}) async {
    if (_activePlayerService != null) {
      await _activePlayerService!
          .replaceQueue(trackIds, startIndex: startIndex);
    }
  }

  @override
  Future<List<String>> getHistory() async {
    if (_activePlayerService != null) {
      return _activePlayerService!.getHistory();
    }
    return [];
  }

  @override
  Future<void> clearHistory() async {
    if (_activePlayerService != null) {
      await _activePlayerService!.clearHistory();
    }
  }
}

/// 播放接口实现 - 提供播放状态监控
class PlaybackInterfaceImpl implements PlaybackInterface {
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

  /// 重复模式控制器
  final _repeatModeController = StreamController<RepeatMode>.broadcast();

  /// 随机播放模式控制器
  final _shuffleModeController = StreamController<bool>.broadcast();

  /// 当前播放状态
  PlaybackState _currentState = PlaybackState.none;

  /// 当前播放位置
  Duration _position = Duration.zero;

  /// 当前音量
  double _volume = 1.0;

  /// 当前重复模式
  RepeatMode _repeatMode = RepeatMode.off;

  /// 当前随机播放模式
  bool _shuffleMode = false;

  /// 当前总时长
  Duration _duration = Duration.zero;

  /// 当前订阅
  final List<StreamSubscription> _subscriptions = [];

  /// 设置数据源
  void setSource(PlaybackInterface source) {
    // 取消旧订阅
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    // 订阅新数据源
    _subscriptions.add(source.positionStream.listen(updatePosition));
    _subscriptions.add(source.bufferedPositionStream.listen(updateBufferedPosition));
    _subscriptions.add(source.durationStream.listen((p) {
      _duration = p;
      _durationController.add(p);
    }));
    _subscriptions.add(source.playbackStateStream.listen(updatePlaybackState));
    _subscriptions.add(source.currentTrackStream.listen(updateCurrentTrack));
    _subscriptions.add(source.volumeStream.listen(updateVolume));
    _subscriptions.add(source.repeatModeStream.listen(updateRepeatMode));
    _subscriptions.add(source.shuffleModeStream.listen(updateShuffleMode));

    // 初始同步
    _position = source.position;
    _duration = source.duration;
    _currentState = source.currentState;
    _volume = source.volume;
    _repeatMode = source.repeatMode;
    _shuffleMode = source.shuffleMode;
  }

  @override
  Stream<Duration> get positionStream => _positionController.stream;

  @override
  Stream<Duration> get bufferedPositionStream =>
      _bufferedPositionController.stream;

  @override
  Stream<Duration> get durationStream => _durationController.stream;

  @override
  Stream<PlaybackState> get playbackStateStream =>
      _playbackStateController.stream;

  @override
  Stream<String?> get currentTrackStream => _currentTrackController.stream;

  @override
  Stream<double> get volumeStream => _volumeController.stream;

  @override
  Stream<RepeatMode> get repeatModeStream => _repeatModeController.stream;

  @override
  Stream<bool> get shuffleModeStream => _shuffleModeController.stream;

  @override
  PlaybackState get currentState => _currentState;

  @override
  double get volume => _volume;

  @override
  RepeatMode get repeatMode => _repeatMode;

  @override
  bool get shuffleMode => _shuffleMode;

  @override
  Duration get duration => _duration;

  @override
  Duration get position => _position;

  /// 更新播放位置
  void updatePosition(Duration position) {
    _position = position;
    _positionController.add(position);
  }

  /// 更新缓冲位置
  void updateBufferedPosition(Duration position) {
    _bufferedPositionController.add(position);
  }

  /// 更新总时长
  void updateDuration(Duration duration) {
    _durationController.add(duration);
  }

  /// 更新播放状态
  void updatePlaybackState(PlaybackState state) {
    _currentState = state;
    _playbackStateController.add(state);
  }

  /// 更新当前曲目
  void updateCurrentTrack(String? trackId) {
    _currentTrackController.add(trackId);
  }

  /// 更新音量
  void updateVolume(double volume) {
    _volume = volume;
    _volumeController.add(volume);
  }

  /// 更新重复模式
  void updateRepeatMode(RepeatMode mode) {
    _repeatMode = mode;
    _repeatModeController.add(mode);
  }

  /// 更新随机播放模式
  void updateShuffleMode(bool enabled) {
    _shuffleMode = enabled;
    _shuffleModeController.add(enabled);
  }

  /// 释放资源
  void dispose() {
    _positionController.close();
    _bufferedPositionController.close();
    _durationController.close();
    _playbackStateController.close();
    _currentTrackController.close();
    _volumeController.close();
    _repeatModeController.close();
    _shuffleModeController.close();
  }
}
