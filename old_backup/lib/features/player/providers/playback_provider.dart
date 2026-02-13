import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/player/player_interface.dart';

import '../../../core/base/interfaces/player/playback_interface.dart';
import '../services/playback_service_impl.dart';

/// 播放控制状态 - 存储播放控制的当前状态
class PlaybackStateData {  // 将类名从PlaybackState改为PlaybackStateData
  /// 当前播放位置
  final Duration position;

  /// 当前缓冲位置
  final Duration bufferedPosition;

  /// 当前曲目总时长
  final Duration duration;

  /// 当前播放状态
  final PlaybackState playbackState;  // 使用接口中定义的枚举

  /// 当前音量
  final double volume;

  /// 当前重复模式
  final RepeatMode repeatMode;

  /// 当前随机播放模式
  final bool shuffleMode;

  /// 当前曲目ID
  final String? currentTrackId;

  /// 构造函数
  const PlaybackStateData({
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.duration = Duration.zero,
    this.playbackState = PlaybackState.none,
    this.volume = 1.0,
    this.repeatMode = RepeatMode.off,
    this.shuffleMode = false,
    this.currentTrackId,
  });

  /// 复制并更新状态
  PlaybackStateData copyWith({
    Duration? position,
    Duration? bufferedPosition,
    Duration? duration,
    PlaybackState? playbackState,
    double? volume,
    RepeatMode? repeatMode,
    bool? shuffleMode,
    String? currentTrackId,
  }) {
    return PlaybackStateData(
      position: position ?? this.position,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      duration: duration ?? this.duration,
      playbackState: playbackState ?? this.playbackState,
      volume: volume ?? this.volume,
      repeatMode: repeatMode ?? this.repeatMode,
      shuffleMode: shuffleMode ?? this.shuffleMode,
      currentTrackId: currentTrackId ?? this.currentTrackId,
    );
  }

  @override
  String toString() {
    return 'PlaybackStateData(position: $position, bufferedPosition: $bufferedPosition, '
        'duration: $duration, playbackState: $playbackState, volume: $volume, '
        'repeatMode: $repeatMode, shuffleMode: $shuffleMode, currentTrackId: $currentTrackId)';
  }
}

/// 播放控制状态提供者 - 管理播放控制状态
class PlaybackStateNotifier extends StateNotifier<PlaybackStateData> {
  /// 播放控制服务
  final PlaybackServiceImpl _playbackService;

  /// 订阅列表
  final List<StreamSubscription> _subscriptions = [];

  /// 构造函数
  PlaybackStateNotifier(this._playbackService) : super(const PlaybackStateData()) {
    _initialize();
  }

  /// 初始化
  void _initialize() {
    // 监听播放位置变化
    _subscriptions.add(_playbackService.positionStream.listen((position) {
      state = state.copyWith(position: position);
    }));

    // 监听缓冲位置变化
    _subscriptions
        .add(_playbackService.bufferedPositionStream.listen((position) {
      state = state.copyWith(bufferedPosition: position);
    }));

    // 监听总时长变化
    _subscriptions.add(_playbackService.durationStream.listen((duration) {
      state = state.copyWith(duration: duration);
    }));

    // 监听播放状态变化
    _subscriptions
        .add(_playbackService.playbackStateStream.listen((playbackState) {
      state = state.copyWith(playbackState: playbackState);
    }));

    // 监听当前曲目变化
    _subscriptions.add(_playbackService.currentTrackStream.listen((trackId) {
      state = state.copyWith(currentTrackId: trackId);
    }));

    // 监听音量变化
    _subscriptions.add(_playbackService.volumeStream.listen((volume) {
      state = state.copyWith(volume: volume);
    }));
  }

  /// 播放曲目
  Future<void> playTrack(String trackId) async {
    await _playbackService.playTrack(trackId);
  }

  /// 暂停播放
  Future<void> pause() async {
    await _playbackService.pausePlayback();
  }

  /// 恢复播放
  Future<void> resume() async {
    await _playbackService.resumePlayback();
  }

  /// 跳转到指定位置
  Future<void> seekTo(Duration position) async {
    await _playbackService.seekToPosition(position.inMilliseconds);
  }

  /// 设置音量
  Future<void> setVolume(double volume) async {
    await _playbackService.setVolume(volume);
  }

  /// 下一曲
  Future<void> next() async {
    await _playbackService.nextTrack();
  }

  /// 上一曲
  Future<void> previous() async {
    await _playbackService.previousTrack();
  }

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode) async {
    // 这里需要在playback_service中添加相应的方法
    // 暂时直接更新状态
    state = state.copyWith(repeatMode: mode);
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    // 这里需要在playback_service中添加相应的方法
    // 暂时直接更新状态
    state = state.copyWith(shuffleMode: enabled);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}

/// 播放控制状态提供者
final playbackStateProvider =
    StateNotifierProvider<PlaybackStateNotifier, PlaybackStateData>((ref) {
  final playbackService = PlaybackServiceImpl();
  return PlaybackStateNotifier(playbackService);
});
