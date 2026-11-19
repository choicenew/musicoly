import 'package:meta/meta.dart';

@immutable
class AlbumEntity {
  final String id;
  final String platform;
  final String name;
  final String? imageUrl;
  final String? artistName;
  final int trackCount;

  const AlbumEntity({
    required this.id,
    required this.platform,
    required this.name,
    this.imageUrl,
    this.artistName,
    this.trackCount = 0,
  });
}
