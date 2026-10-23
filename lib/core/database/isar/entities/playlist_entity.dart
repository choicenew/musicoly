import 'package:isar_community/isar.dart';

part 'playlist_entity.g.dart';

@collection
class PlaylistEntity {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  late String playlistId;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  String? description;
  String? imageUrl;
  String? author;

  late String platform;

  // List of track IDs in order
  List<String>? trackIds;

  @Index()
  DateTime createdAt = DateTime.now();
}
