import 'package:music_source_protocol/music_source_protocol.dart';

/// Subsonic / Jellyfin / Emby Private Server Driver (Finamp & Polaris Inspired)
class SubsonicDriver implements TrackSourceDriver, SearchSourceDriver {
  String _serverUrl = '';
  String _username = '';
  String _token = '';
  bool _isConnected = false;

  @override
  String get platformId => 'subsonic';

  @override
  String get platformName => 'Subsonic / Jellyfin NAS';

  @override
  Future<void> initialize() async {}

  Future<bool> connect({
    required String url,
    required String username,
    required String password,
  }) async {
    _serverUrl = url;
    _username = username;
    _token = 'token_${DateTime.now().millisecondsSinceEpoch}';
    _isConnected = true;
    return true;
  }

  @override
  Future<bool> isAvailable() async => _isConnected;

  @override
  Future<TrackEntity?> getTrackDetails(String trackId) async {
    if (!_isConnected) return null;
    return TrackEntity(
      id: trackId,
      platform: platformId,
      name: 'NAS Subsonic Track $trackId',
      durationMs: 240000,
    );
  }

  @override
  Future<String?> getAudioStreamUrl(String trackId) async {
    if (!_isConnected) return null;
    return '$_serverUrl/rest/stream?id=$trackId&u=$_username&t=$_token';
  }

  @override
  Future<List<TrackEntity>> searchTracks(String query, {int limit = 20}) async => [];

  @override
  Future<List<AlbumEntity>> searchAlbums(String query, {int limit = 20}) async => [];

  @override
  Future<List<ArtistEntity>> searchArtists(String query, {int limit = 20}) async => [];

  @override
  Future<List<PlaylistEntity>> searchPlaylists(String query, {int limit = 20}) async => [];

  @override
  Future<void> dispose() async {
    _isConnected = false;
  }
}
