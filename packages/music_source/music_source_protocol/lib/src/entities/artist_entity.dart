import 'package:meta/meta.dart';

@immutable
class ArtistEntity {
  final String id;
  final String platform;
  final String name;
  final String? imageUrl;

  const ArtistEntity({
    required this.id,
    required this.platform,
    required this.name,
    this.imageUrl,
  });
}
