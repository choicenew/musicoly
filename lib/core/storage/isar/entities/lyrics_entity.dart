import 'package:isar_community/isar.dart';

part 'lyrics_entity.g.dart';

@collection
class LyricsEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String lyricsId;

  @Index()
  late String trackId;

  String? filePath;

  bool isSynced = false;

  String? language;
  String? source;

  @Index()
  DateTime createdAt = DateTime.now();

  DateTime updatedAt = DateTime.now();
}
