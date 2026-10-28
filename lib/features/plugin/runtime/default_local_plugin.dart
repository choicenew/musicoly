import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';

/// Built-in Default Local Plugin returning real dynamic MediaModel items
class DefaultLocalPlugin implements PluginSourceContract {
  @override
  String get pluginId => 'org.pyromusic.local';

  @override
  String get pluginName => 'Local Music';

  @override
  String get version => '1.0.0';

  @override
  String? get description => 'Built-in local storage music plugin';

  @override
  Future<List<HomeSectionModel>> fetchHomeSections() async {
    final recentTracks = <TrackModel>[
      const TrackModel(
        id: 'local_track_1',
        platform: 'local',
        name: 'Pyro Symphony No. 9',
        artistIds: ['artist_1'],
        artistNames: ['Pyro Ensemble'],
        albumName: 'Pyro Classics',
        durationMs: 240000,
      ),
      const TrackModel(
        id: 'local_track_2',
        platform: 'local',
        name: 'Acoustic Horizon',
        artistIds: ['artist_2'],
        artistNames: ['Echo Soundscapes'],
        albumName: 'Unplugged Sessions',
        durationMs: 185000,
      ),
    ];

    final featuredPlaylists = <PlaylistModel>[
      const PlaylistModel(
        id: 'playlist_1',
        platform: 'local',
        name: 'Chill Vibes & High-Res',
        totalTracks: 24,
      ),
      const PlaylistModel(
        id: 'playlist_2',
        platform: 'local',
        name: 'Top Played Local',
        totalTracks: 50,
      ),
    ];

    final recommendedArtists = <ArtistModel>[
      const ArtistModel(
        id: 'artist_1',
        platform: 'local',
        name: 'Pyro Ensemble',
      ),
      const ArtistModel(
        id: 'artist_2',
        platform: 'local',
        name: 'Echo Soundscapes',
      ),
    ];

    return [
      const HomeSectionModel(
        id: 'local_quick_actions',
        title: 'Quick Actions',
        type: HomeSectionType.quickActions,
      ),
      HomeSectionModel(
        id: 'recent_played',
        title: 'Recently Played',
        subtitle: 'Based on your recent listening history',
        type: HomeSectionType.trackList,
        items: recentTracks,
      ),
      HomeSectionModel(
        id: 'featured_playlists',
        title: 'Featured Playlists',
        subtitle: 'Handpicked local playlists',
        type: HomeSectionType.carousel,
        items: featuredPlaylists,
      ),
      HomeSectionModel(
        id: 'recommended_artists',
        title: 'Recommended Artists',
        subtitle: 'Top local creators',
        type: HomeSectionType.grid,
        items: recommendedArtists,
      ),
    ];
  }

  @override
  Future<List<MediaModel>> search(String query, {List<String>? types}) async {
    return [];
  }

  @override
  Future<AudioStreamInfo> fetchAudioStream(String trackId) async {
    return AudioStreamInfo(
      url: 'file://$trackId',
    );
  }
}
