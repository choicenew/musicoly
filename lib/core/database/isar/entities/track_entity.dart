import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/models/track_model.dart';

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
  bool isFavorite = false;

  @Index()
  DateTime createdAt = DateTime.now();

  @Index()
  DateTime? lastPlayedAt;

  @Index()
  int playCount = 0;

  @Index()
  int skipCount = 0;

  @Index()
  int totalPlayDuration = 0;

  /// Convert to TrackModel
  TrackModel toModel() {
    return TrackModel(
      id: trackId,
      name: name,
      platform: platform,
      imageUrl: imageUrl,
      artistIds: artistIds ?? [],
      artistNames: artistNames ?? [],
      albumId: albumId,
      albumName: albumName,
      durationMs: durationMs,
      isPlayable: isPlayable,
      isExplicit: isExplicit,
      popularity: popularity,
      previewUrl: previewUrl,
      localPath: localPath,
      isFavorite: isFavorite,
    );
  }
}
