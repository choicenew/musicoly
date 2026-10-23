import 'package:pyro_music/core/models/track_model.dart';

/// 轨道未找到异常
class TrackNotFoundError extends Error {
  final TrackModel track;
  final String message;

  TrackNotFoundError(this.track, [this.message = '未找到匹配的音源']);

  @override
  String toString() =>
      'TrackNotFoundError: $message for track ${track.name} by ${track.artistNames.join(", ")}.';
}

/// 音源获取失败异常
class SourceFetchError extends Error {
  final TrackModel track;
  final String source;
  final String message;

  SourceFetchError(this.track, this.source, [this.message = '获取音源失败']);

  @override
  String toString() =>
      'SourceFetchError: $message from $source for track ${track.name}.';
}
