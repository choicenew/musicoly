import 'package:meta/meta.dart';

@immutable
class TrackEntity {
  final String id;
  final String platform;
  final String name;
  final String? imageUrl;
  final List<String> artistNames;
  final String? albumName;
  final int durationMs;
  final bool isPlayable;
  final String? audioStreamUrl;
  final Map<String, dynamic> metadata;

  const TrackEntity({
    required this.id,
    required this.platform,
    required this.name,
    this.imageUrl,
    this.artistNames = const [],
    this.albumName,
    required this.durationMs,
    this.isPlayable = true,
    this.audioStreamUrl,
    this.metadata = const {},
  });
}
