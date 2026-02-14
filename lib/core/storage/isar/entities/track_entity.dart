import 'package:isar_community/isar.dart';

part 'track_entity.g.dart';

@collection
class TrackEntity {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  late String trackId;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  late String platform;

  String? imageUrl;

  // Store basic artist info embedded or as list of strings for quick access
  List<String>? artistIds;
  List<String>? artistNames;

  String? albumId;
  String? albumName;

  late int durationMs;

  bool isPlayable = true;
  bool isExplicit = false;

  int? popularity;

  String? previewUrl;
  
  String? localPath;

  // JSON string for platform specific metadata
  String? platformMetadata;

  @Index()
  DateTime createdAt = DateTime.now();
}
