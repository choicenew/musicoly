import 'package:pyro_music/features/plugin/contracts/plugin_port_contracts.dart';
import 'package:pyro_music/features/plugin/entities/media_entity.dart';

/// Built-in Default System Plugin providing local playback, search, and home sections
class DefaultSystemPlugin implements UniversalPluginPort {
  @override
  PluginManifest get manifest => const PluginManifest(
        id: 'org.pyromusic.system',
        name: 'Local & System Music',
        version: '2.0.0',
        description: 'Built-in local storage and system music plugin',
        baseUrl: 'file://local',
        capabilities: {
          PluginCapability.explore,
          PluginCapability.search,
          PluginCapability.stream,
          PluginCapability.details,
          PluginCapability.lyrics,
        },
        isNsfw: false,
        riskLevel: 'safe',
      );

  @override
  Future<void> init(Map<String, dynamic> context) async {
    // System plugin initialization
  }

  @override
  List<Map<String, dynamic>> getConfigSchema() => [];

  @override
  Future<List<HomeSectionEntity>> fetchExploreSections() async {
    final recentTracks = [
      const MediaEntity(
        id: 'local_demo_1',
        title: 'Pyro Symphony No. 9',
        type: MediaType.music,
        creators: CreatorsMatrix(singer: 'Pyro Ensemble'),
        album: 'Pyro Classics',
        durationSeconds: 240,
        mediaUrl: 'asset://assets/audio/demo.mp3',
      ),
      const MediaEntity(
        id: 'local_demo_2',
        title: 'Acoustic Horizon',
        type: MediaType.music,
        creators: CreatorsMatrix(singer: 'Echo Soundscapes'),
        album: 'Unplugged Sessions',
        durationSeconds: 185,
      ),
    ];

    return [
      const HomeSectionEntity(
        id: 'local_quick_actions',
        title: 'Quick Actions',
        type: HomeSectionType.quickActions,
        items: [],
      ),
      HomeSectionEntity(
        id: 'recent_played',
        title: 'Recently Played',
        subtitle: 'From local storage and recent listening',
        type: HomeSectionType.trackList,
        items: recentTracks,
      ),
    ];
  }

  @override
  Future<List<MediaEntity>> exploreCategory(String categoryId, {int page = 1, int limit = 20}) async {
    return [];
  }

  @override
  Future<List<MediaEntity>> search(
    String query, {
    int page = 1,
    int limit = 20,
    List<MediaType>? types,
  }) async {
    if (query.isEmpty) return [];

    return [
      MediaEntity(
        id: 'search_local_1',
        title: 'Local Match: $query',
        type: MediaType.music,
        creators: const CreatorsMatrix(singer: 'Local Artist'),
        album: 'Local Music Library',
        durationSeconds: 200,
      ),
    ];
  }

  @override
  Future<AudioStreamInfo> resolveAudioStream(
    String trackId, {
    String? preferredQuality,
    String? preferredCodec,
  }) async {
    return AudioStreamInfo(
      url: trackId.startsWith('http') || trackId.startsWith('file')
          ? trackId
          : 'file://$trackId',
      quality: preferredQuality ?? 'lossless',
    );
  }

  @override
  Future<MediaEntity> getDetail(String contentId) async {
    return MediaEntity(
      id: contentId,
      title: 'Local Content Detail',
      type: MediaType.music,
      creators: const CreatorsMatrix(singer: 'Local Artist'),
    );
  }

  @override
  Future<String?> fetchLyrics(String trackId, {String? title, String? artist}) async {
    return null;
  }

  @override
  Future<bool> scrobble(String contentId, Map<String, dynamic> payload) async {
    return true;
  }

  @override
  Future<bool> push(String contentId, Map<String, dynamic> payload) async {
    return true;
  }
}
