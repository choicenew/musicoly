import 'package:pyro_music/features/plugin/entities/media_entity.dart';

/// Capability flags declaring what features a plugin supports
enum PluginCapability {
  /// Explore/home feed/recommendations/charts
  explore,

  /// Multi-type keyword search
  search,

  /// Direct audio stream resolving
  stream,

  /// Detailed album/playlist/channel metadata and tracklist
  details,

  /// LRC and plain text lyrics
  lyrics,

  /// Progress tracking and silent scrobbling (Last.fm, etc.)
  scrobble,

  /// Active item push (Zotero, etc.)
  push,
}

/// Metadata, capability declaration, and zero-trust risk level of a plugin
class PluginManifest {
  final String id;
  final String name;
  final String version;
  final String? description;
  final String baseUrl;
  final Set<PluginCapability> capabilities;
  final bool isNsfw;
  final String riskLevel;

  const PluginManifest({
    required this.id,
    required this.name,
    required this.version,
    this.description,
    required this.baseUrl,
    required this.capabilities,
    this.isNsfw = false,
    this.riskLevel = 'safe',
  });
}

/// Explore and home feed recommendation port
abstract class ExplorePluginPort {
  Future<List<HomeSectionEntity>> fetchExploreSections();
  Future<List<MediaEntity>> exploreCategory(String categoryId, {int page = 1, int limit = 20});
}

/// Keyword search port
abstract class SearchPluginPort {
  Future<List<MediaEntity>> search(
    String query, {
    int page = 1,
    int limit = 20,
    List<MediaType>? types,
  });
}

/// Audio stream resolver port
abstract class StreamResolverPort {
  Future<AudioStreamInfo> resolveAudioStream(
    String trackId, {
    String? preferredQuality,
    String? preferredCodec,
  });
}

/// Detailed album/playlist/channel metadata loader port
abstract class DetailsPluginPort {
  Future<MediaEntity> getDetail(String contentId);
}

/// Dedicated lyrics resolver port
abstract class LyricsPluginPort {
  Future<String?> fetchLyrics(String trackId, {String? title, String? artist});
}

/// Progress scrobbler port
abstract class ScrobblePluginPort {
  Future<bool> scrobble(String contentId, Map<String, dynamic> payload);
}

/// Active push port
abstract class PushPluginPort {
  Future<bool> push(String contentId, Map<String, dynamic> payload);
}

/// Universal plugin contract combining all specialized ports
abstract class UniversalPluginPort implements
    ExplorePluginPort,
    SearchPluginPort,
    StreamResolverPort,
    DetailsPluginPort,
    LyricsPluginPort,
    ScrobblePluginPort,
    PushPluginPort {
  PluginManifest get manifest;
  Future<void> init(Map<String, dynamic> context);
  List<Map<String, dynamic>> getConfigSchema();
}
