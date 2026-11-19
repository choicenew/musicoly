import 'package:music_source_protocol/music_source_protocol.dart';

class SpotifyDriver implements TrackSourceDriver, SearchSourceDriver, LyricsSourceDriver {
  @override
  String get platformId => 'spotify';

  @override
  String get platformName => 'Spotify';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<TrackEntity?> getTrackDetails(String trackId) async {
    return TrackEntity(
      id: trackId,
      platform: platformId,
      name: 'Spotify Track $trackId',
      durationMs: 200000,
    );
  }

  @override
  Future<String?> getAudioStreamUrl(String trackId) async => null;

  @override
  Future<List<TrackEntity>> searchTracks(String query, {int limit = 20}) async => [];

  @override
  Future<List<AlbumEntity>> searchAlbums(String query, {int limit = 20}) async => [];

  @override
  Future<List<ArtistEntity>> searchArtists(String query, {int limit = 20}) async => [];

  @override
  Future<List<PlaylistEntity>> searchPlaylists(String query, {int limit = 20}) async => [];

  @override
  Future<LyricsEntity?> getLyrics(String trackId, {String? trackName, String? artistName}) async => null;

  @override
  Future<void> dispose() async {}
}
