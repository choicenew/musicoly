import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/base/interfaces/player/player_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/base/interfaces/player/playback_interface.dart';
import '../services/playback_service_impl.dart';

part 'playback_provider.freezed.dart';
part 'playback_provider.g.dart';

/// 播放控制状态 - 存储播放控制的当前状态
@freezed
abstract class PlaybackStateData with _$PlaybackStateData {
  const factory PlaybackStateData({
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,
    @Default(Duration.zero) Duration duration,
    @Default(PlaybackState.none) PlaybackState playbackState,
    @Default(1.0) double volume,
    @Default(RepeatMode.off) RepeatMode repeatMode,
    @Default(false) bool shuffleMode,
    String? currentTrackId,
  }) = _PlaybackStateData;
}


/// 播放控制状态提供者 - 管理播放控制状态
@Riverpod(keepAlive: true)
class PlaybackStateNotifier extends _$PlaybackStateNotifier {
  /// 播放控制服务
  late final PlaybackServiceImpl _playbackService;

  /// 订阅列表
  final List<StreamSubscription> _subscriptions = [];

  @override
  PlaybackStateData build() {
    _playbackService = PlaybackServiceImpl();
    _initialize();
    
    // 清理资源
    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
      _playbackService.dispose();
    });

    return const PlaybackStateData();
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
    await _playbackService.setRepeatMode(mode);
    state = state.copyWith(repeatMode: mode);
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    await _playbackService.setShuffleMode(enabled);
    state = state.copyWith(shuffleMode: enabled);
  }
}
