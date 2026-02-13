import 'package:flutter/foundation.dart';

/// 播放状态类 - 表示播放器的当前播放状态
@immutable
class PlaybackState {
  /// 是否正在播放
  final bool playing;

  /// 当前播放位置（毫秒）
  final int position;

  /// 缓冲位置（毫秒）
  final int bufferedPosition;

  /// 播放速度
  final double speed;

  /// 构造函数
  const PlaybackState({
    this.playing = false,
    this.position = 0,
    this.bufferedPosition = 0,
    this.speed = 1.0,
  });

  /// 复制并更新状态
  PlaybackState copyWith({
    bool? playing,
    int? position,
    int? bufferedPosition,
    double? speed,
  }) {
    return PlaybackState(
      playing: playing ?? this.playing,
      position: position ?? this.position,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      speed: speed ?? this.speed,
    );
  }

  @override
  String toString() {
    return 'PlaybackState(playing: $playing, position: $position, '
        'bufferedPosition: $bufferedPosition, speed: $speed)';
  }
}
