import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/base/interfaces/player/playback_interface.dart';
import '../../../core/base/interfaces/player/player_interface.dart';
import '../providers/playback_provider.dart';

/// 播放控制控制器 - 提供播放控制功能
///
/// 与播放控制状态提供者交互，提供播放控制功能
class PlaybackController {
  /// 引用阅读器
  final Ref _ref;

  /// 构造函数
  PlaybackController(this._ref);

  /// 获取播放控制状态提供者
  PlaybackStateNotifier get _playbackStateNotifier =>
      _ref.read(playbackStateProvider.notifier);

  /// 获取播放控制状态
  PlaybackStateData get playbackState => _ref.read(playbackStateProvider);

  /// 获取当前播放位置
  Duration get position => playbackState.position;

  /// 获取当前缓冲位置
  Duration get bufferedPosition => playbackState.bufferedPosition;

  /// 获取当前曲目总时长
  Duration get duration => playbackState.duration;

  /// 获取当前播放状态
  PlaybackState get state => playbackState.playbackState;

  /// 获取当前音量
  double get volume => playbackState.volume;

  /// 获取当前重复模式
  RepeatMode get repeatMode => playbackState.repeatMode;

  /// 获取当前随机播放模式
  bool get shuffleMode => playbackState.shuffleMode;

  /// 获取当前曲目ID
  String? get currentTrackId => playbackState.currentTrackId;

  /// 播放曲目
  Future<void> playTrack(String trackId) async {
    await _playbackStateNotifier.playTrack(trackId);
  }

  /// 暂停播放
  Future<void> pause() async {
    await _playbackStateNotifier.pause();
  }

  /// 恢复播放
  Future<void> resume() async {
    await _playbackStateNotifier.resume();
  }

  /// 跳转到指定位置
  Future<void> seekTo(Duration position) async {
    await _playbackStateNotifier.seekTo(position);
  }

  /// 设置音量
  Future<void> setVolume(double volume) async {
    if (volume < 0.0) {
      volume = 0.0;
    } else if (volume > 1.0) {
      volume = 1.0;
    }
    await _playbackStateNotifier.setVolume(volume);
  }

  /// 下一曲
  Future<void> next() async {
    await _playbackStateNotifier.next();
  }

  /// 上一曲
  Future<void> previous() async {
    await _playbackStateNotifier.previous();
  }

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode) async {
    final newState = playbackState.copyWith(repeatMode: mode);
    _ref.read(playbackStateProvider.notifier).state = newState;
  }

  /// 切换重复模式
  Future<void> toggleRepeatMode() async {
    RepeatMode newMode;
    switch (repeatMode) {
      case RepeatMode.off:
        newMode = RepeatMode.all;
        break;
      case RepeatMode.all:
        newMode = RepeatMode.one;
        break;
      case RepeatMode.one:
        newMode = RepeatMode.off;
        break;
    }
    await setRepeatMode(newMode);
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    // 这里需要在playback_provider中添加相应的方法
    // 暂时使用状态更新的方式实现
    final newState = playbackState.copyWith(shuffleMode: enabled);
    _ref.read(playbackStateProvider.notifier).state = newState;
  }

  /// 切换随机播放模式
  Future<void> toggleShuffleMode() async {
    await setShuffleMode(!shuffleMode);
  }

  /// 计算播放进度百分比
  double get progressPercentage {
    if (duration.inMilliseconds == 0) return 0.0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  /// 计算缓冲进度百分比
  double get bufferedPercentage {
    if (duration.inMilliseconds == 0) return 0.0;
    return bufferedPosition.inMilliseconds / duration.inMilliseconds;
  }

  /// 格式化时间
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  /// 获取当前播放位置的格式化时间
  String get positionText => formatDuration(position);

  /// 获取当前曲目总时长的格式化时间
  String get durationText => formatDuration(duration);

  /// 获取剩余时间
  Duration get remainingTime => duration - position;

  /// 获取剩余时间的格式化文本
  String get remainingTimeText => formatDuration(remainingTime);

  /// 检查是否正在播放
  bool get isPlaying => state == PlaybackState.playing;

  /// 检查是否已暂停
  bool get isPaused => state == PlaybackState.paused;

  /// 检查是否正在缓冲
  bool get isBuffering => state == PlaybackState.buffering;

  /// 检查是否已完成
  bool get isCompleted => state == PlaybackState.completed;

  /// 检查是否发生错误
  bool get hasError => state == PlaybackState.error;

  /// 检查是否有曲目加载
  bool get hasTrack => currentTrackId != null;

  /// 检查是否可以播放
  bool get canPlay => hasTrack && (isPaused || isCompleted);

  /// 检查是否可以暂停
  bool get canPause => hasTrack && isPlaying;

  /// 检查是否可以跳转
  bool get canSeek => hasTrack && duration.inMilliseconds > 0;

  /// 播放/暂停切换
  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  /// 跳转到百分比位置
  Future<void> seekToPercentage(double percentage) async {
    if (percentage < 0.0) {
      percentage = 0.0;
    } else if (percentage > 1.0) {
      percentage = 1.0;
    }

    final newPosition =
        Duration(milliseconds: (duration.inMilliseconds * percentage).round());
    await seekTo(newPosition);
  }

  /// 快进指定时间
  Future<void> fastForward(
      [Duration amount = const Duration(seconds: 10)]) async {
    final newPosition = position + amount;
    if (newPosition > duration) {
      await seekTo(duration);
    } else {
      await seekTo(newPosition);
    }
  }

  /// 快退指定时间
  Future<void> rewind([Duration amount = const Duration(seconds: 10)]) async {
    final newPosition = position - amount;
    if (newPosition < Duration.zero) {
      await seekTo(Duration.zero);
    } else {
      await seekTo(newPosition);
    }
  }
}

/// 播放控制控制器提供者
final playbackControllerProvider = Provider<PlaybackController>((ref) {
  return PlaybackController(ref);
});
