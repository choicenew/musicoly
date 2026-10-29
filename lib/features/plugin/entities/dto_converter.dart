import 'package:pyro_music/core/models/home_section_model.dart' as host_section;
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/plugin/entities/media_entity.dart';

/// DTO Converter between MediaEntity and host domain models
class DtoConverter {
  /// Convert MediaEntity to host TrackModel
  static TrackModel toTrackModel(MediaEntity entity, {String platform = 'plugin'}) {
    final artistName = entity.creators.singer ??
        entity.creators.author ??
        'Unknown Artist';

    return TrackModel(
      id: entity.id,
      platform: platform,
      name: entity.title,
      imageUrl: entity.coverUrl.isNotEmpty ? entity.coverUrl : entity.thumbUrl,
      artistIds: [entity.creators.singer ?? 'unknown_artist'],
      artistNames: [artistName],
      albumName: entity.album,
      durationMs: (entity.durationSeconds ?? 0) * 1000,
      trackNumber: entity.trackNumber,
      audioStreamUrl: entity.mediaUrl,
      lyrics: entity.lyrics,
      description: entity.description,
      tags: entity.tags,
      platformMetadata: entity.extra,
    );
  }

  /// Convert host TrackModel to MediaEntity
  static MediaEntity toMediaEntity(TrackModel model) {
    final primaryArtist = model.artistNames.isNotEmpty
        ? model.artistNames.first
        : 'Unknown Artist';

    return MediaEntity(
      id: model.id,
      title: model.name,
      type: MediaType.music,
      creators: CreatorsMatrix(singer: primaryArtist),
      thumbUrl: model.imageUrl ?? '',
      coverUrl: model.imageUrl ?? '',
      album: model.albumName,
      trackNumber: model.trackNumber,
      durationSeconds: model.durationMs ~/ 1000,
      lyrics: model.lyrics,
      mediaUrl: model.audioStreamUrl,
      description: model.description,
      tags: model.tags,
      extra: model.platformMetadata,
    );
  }

  /// Convert HomeSectionEntity to host HomeSectionModel
  static host_section.HomeSectionModel toHostHomeSection(HomeSectionEntity entity, {String platform = 'plugin'}) {
    host_section.HomeSectionType hostType;
    switch (entity.type) {
      case HomeSectionType.quickActions:
        hostType = host_section.HomeSectionType.quickActions;
        break;
      case HomeSectionType.trackList:
        hostType = host_section.HomeSectionType.trackList;
        break;
      case HomeSectionType.carousel:
        hostType = host_section.HomeSectionType.carousel;
        break;
      case HomeSectionType.grid:
        hostType = host_section.HomeSectionType.grid;
        break;
      case HomeSectionType.adBanner:
        hostType = host_section.HomeSectionType.adBanner;
        break;
      case HomeSectionType.adCard:
        hostType = host_section.HomeSectionType.adCard;
        break;
    }

    final items = entity.items
        .map((e) => toTrackModel(e, platform: platform))
        .toList();

    return host_section.HomeSectionModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      type: hostType,
      items: items,
      extra: entity.extra,
    );
  }
}
