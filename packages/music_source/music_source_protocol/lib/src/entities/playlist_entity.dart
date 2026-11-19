import 'package:meta/meta.dart';

@immutable
class PlaylistEntity {
  final String id;
  final String platform;
  final String name;
  final String? imageUrl;
  final String? description;
  final int trackCount;

  const PlaylistEntity({
    required this.id,
    required this.platform,
    required this.name,
    this.imageUrl,
    this.description,
    this.trackCount = 0,
  });
}
