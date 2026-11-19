import 'package:meta/meta.dart';

enum PlaybackStatus { stopped, playing, paused, buffering }

@immutable
class PlaybackStateEntity {
  final PlaybackStatus status;
  final Duration position;
  final Duration duration;
  final double volume;

  const PlaybackStateEntity({
    this.status = PlaybackStatus.stopped,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.volume = 1.0,
  });
}
