import 'package:music_source_protocol/music_source_protocol.dart';

class YouTubeMusicDriver implements TrackSourceDriver, SearchSourceDriver {
  @override
  String get platformId => 'youtube_music';

  @override
  String get platformName => 'YouTube Music';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<TrackEntity?> getTrackDetails(String trackId) async {
    return TrackEntity(
      id: trackId,
      platform: platformId,
      name: 'YouTube Track $trackId',
      durationMs: 180000,
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
  Future<void> dispose() async {}
}
