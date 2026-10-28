import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/core/services/base_service.dart';

abstract class PlaylistInterface {
  String get id;
  String get platform;
  String get name;
  String? get description;
  String? get imageUrl;
  int get totalTracks;
}

abstract class PlaylistService extends BaseService {
  Future<List<PlaylistInterface>> getUserPlaylists({int limit = 50, int offset = 0});
  Future<PlaylistInterface?> getPlaylist(String playlistId);
  Future<List<TrackInterface>> getPlaylistTracks(String playlistId, {int limit = 100, int offset = 0});
  Future<PlaylistInterface?> createPlaylist({
    required String name,
    String? description,
    bool public = false,
    bool collaborative = false,
  });
  Future<bool> updatePlaylist({
    required String playlistId,
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  });
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int position = 0,
  });
  Future<bool> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  });
  Future<bool> deletePlaylist(String playlistId);
  Future<List<TrackInterface>> getSmartPlaylistTracks(String type, {int limit = 50});
  Future<bool> followPlaylist(String playlistId);
  Future<List<PlaylistInterface>> getFeaturedPlaylists({int limit = 20, int offset = 0});
  Future<bool> isFollowingPlaylist(String playlistId);
  Future<bool> reorderPlaylistTracks({
    required String playlistId,
    required int rangeStart,
    required int insertBefore,
    required int rangeLength,
  });
  Future<bool> unfollowPlaylist(String playlistId);
  Future<bool> toggleFavorite(String trackId);
  Future<bool> isFavorite(String trackId);
}
