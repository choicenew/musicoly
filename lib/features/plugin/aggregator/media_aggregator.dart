import 'package:pyro_music/core/models/ad_media_model.dart';
import 'package:pyro_music/core/models/composite_track_model.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/track_model.dart';

/// Deduplication, Dynamic Infiltration, and Ad Spacing Engine
class MediaAggregator {
  /// Generate canonical fingerprint: normalize(artist) + "::" + normalize(title)
  static String generateCanonicalFingerprint(String artist, String title) {
    final cleanArtist = _normalizeString(artist);
    final cleanTitle = _normalizeString(title);
    return '$cleanArtist::$cleanTitle';
  }

  static String _normalizeString(String str) {
    return str
        .toLowerCase()
        .replaceAll(RegExp(r'[\(\)\[\]\{\}\-_\.,!\?\/\\]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Aggregate home sections with Subtle Native In-Stream Ad Infiltration
  static List<HomeSectionModel> aggregateHomeSections(
    List<List<HomeSectionModel>> pluginSectionsList, {
    int maxAdItemInterval = 6, // 1 ad item per 6 content items
  }) {
    final List<HomeSectionModel> contentSections = [];
    final List<AdMediaModel> adPool = [];

    for (final sections in pluginSectionsList) {
      for (final section in sections) {
        if (section.isAdSection ||
            section.type == HomeSectionType.adBanner ||
            section.type == HomeSectionType.adCard) {
          adPool.addAll(section.items.whereType<AdMediaModel>());
        } else {
          contentSections.add(section);
        }
      }
    }

    // Deduplicate content sections by ID
    final Map<String, HomeSectionModel> uniqueContentMap = {};
    for (final section in contentSections) {
      if (!uniqueContentMap.containsKey(section.id)) {
        uniqueContentMap[section.id] = section;
      } else {
        final existing = uniqueContentMap[section.id]!;
        uniqueContentMap[section.id] = HomeSectionModel(
          id: existing.id,
          title: existing.title,
          subtitle: existing.subtitle ?? section.subtitle,
          type: existing.type,
          items: [...existing.items, ...section.items],
          extra: {...existing.extra, ...section.extra},
          isAdSection: false,
        );
      }
    }

    final List<HomeSectionModel> finalSections = [];
    int adIndex = 0;

    // In-Stream Native Infiltration: Mix 1 AdMediaModel inside content section items naturally
    for (final section in uniqueContentMap.values) {
      if (adPool.isNotEmpty &&
          section.items.length >= 2 &&
          adIndex < adPool.length) {
        final currentAd = adPool[adIndex];
        final List<MediaModel> mixedItems = List.from(section.items);

        // Natural insertion position (e.g., at index 2 or 3, never 0)
        final insertPos = mixedItems.length >= 3 ? 2 : mixedItems.length;
        mixedItems.insert(insertPos, currentAd);
        adIndex++;

        finalSections.add(HomeSectionModel(
          id: section.id,
          title: section.title,
          subtitle: section.subtitle,
          type: section.type,
          items: mixedItems,
          extra: section.extra,
          isAdSection: false,
        ));
      } else {
        finalSections.add(section);
      }
    }

    return finalSections;
  }

  /// Create a composite track from multiple track sources matching the same canonical fingerprint
  static CompositeTrackModel buildCompositeTrack({
    required TrackModel primaryTrack,
    required List<SourceInfo> sources,
  }) {
    final artist = primaryTrack.artistNames.isNotEmpty
        ? primaryTrack.artistNames.first
        : '';
    final fingerprint =
        generateCanonicalFingerprint(artist, primaryTrack.name);

    return CompositeTrackModel(
      canonicalId: fingerprint,
      primaryTitle: primaryTrack.name,
      primaryArtist: artist,
      primaryTrack: primaryTrack,
      availableSources: sources,
    );
  }
}
