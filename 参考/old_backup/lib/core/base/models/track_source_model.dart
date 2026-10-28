import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';

/// 音源信息模型
class SourceInfoModel implements SourceInfo {
  @override
  final String id;

  @override
  final String title;

  @override
  final String artist;

  @override
  final String thumbnailUrl;

  @override
  final Duration duration;

  @override
  final AudioSource source;

  const SourceInfoModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.duration,
    required this.source,
  });
}

/// 源映射模型
class SourceMapModel {
  final String id;
  final AudioSource source;
  final Map<String, dynamic> metadata;

  const SourceMapModel({
    required this.id,
    required this.source,
    this.metadata = const {},
  });
}

/// 带有音源的轨道模型
class SourcedTrackModel implements SourcedTrack {
  @override
  final TrackInterface track;

  @override
  final SourceInfo sourceInfo;

  @override
  final List<SourceInfo> siblings;

  @override
  final AudioSource source;

  @override
  final SourceCodecs codec;

  const SourcedTrackModel({
    required this.track,
    required this.sourceInfo,
    required this.siblings,
    required this.source,
    required this.codec,
  });
}
