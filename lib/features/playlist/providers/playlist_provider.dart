import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import '../services/playlist_service_impl.dart';

import 'package:pyro_music/core/services/service_registry.dart';

part 'playlist_provider.freezed.dart';
part 'playlist_provider.g.dart';

/// Provider for the playlist service implementation
@Riverpod(keepAlive: true)
PlaylistServiceImpl playlistService(Ref ref) {
  final registry = ServiceRegistry();
  final service = registry.getService<PlaylistService>('playlist_service');
  return service as PlaylistServiceImpl;
}

/// Playlist state data class
@freezed
abstract class PlaylistStateData with _$PlaylistStateData {
  const factory PlaylistStateData({
    PlaylistModel? selectedPlaylist,
    List<TrackModel>? playlistTracks,
    @Default(false) bool isLoading,
    Object? error,
  }) = _PlaylistStateData;
}

/// Notifier for playlist state
@Riverpod(keepAlive: true)
class PlaylistNotifier extends _$PlaylistNotifier with BaseProviderMixin<PlaylistService> {
  late final PlaylistServiceImpl _playlistService;

  @override
  PlaylistStateData build() {
    _playlistService = ref.watch(playlistServiceProvider);
    return const PlaylistStateData();
  }

  /// Load a playlist by ID
  Future<void> loadPlaylist(String playlistId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final playlist = await _playlistService.getPlaylist(playlistId);
      state = state.copyWith(selectedPlaylist: playlist, isLoading: false);

      // Load the playlist tracks
      if (playlist != null) {
        await loadPlaylistTracks(playlistId);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  /// Load tracks for a playlist
  Future<void> loadPlaylistTracks(String playlistId,
      {int limit = 100, int offset = 0}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final tracks = await _playlistService.getPlaylistTracks(
        playlistId,
        limit: limit,
        offset: offset,
      );
      state = state.copyWith(playlistTracks: tracks, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  /// Create a new playlist
  Future<PlaylistInterface?> createPlaylist({
    required String name,
    String? description,
    bool public = false,
    bool collaborative = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final playlist = await _playlistService.createPlaylist(
        name: name,
        description: description,
        public: public,
        collaborative: collaborative,
      );

      state = state.copyWith(isLoading: false);
      return playlist;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return null;
    }
  }

  /// Delete a playlist
  Future<bool> deletePlaylist(String playlistId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _playlistService.deletePlaylist(playlistId);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Remove tracks from a playlist
  Future<bool> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _playlistService.removeTracksFromPlaylist(
        playlistId: playlistId,
        trackIds: trackIds,
      );
      
      if (success && state.selectedPlaylist?.id == playlistId) {
        // Refresh the tracks list
        await loadPlaylistTracks(playlistId);
      }
      
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Update a playlist's details
  Future<bool> updatePlaylist({
    required String playlistId,
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _playlistService.updatePlaylist(
        playlistId: playlistId,
        name: name,
        description: description,
        public: public,
        collaborative: collaborative,
      );

      // Reload the playlist if update was successful and it's the selected playlist
      if (success && state.selectedPlaylist?.id == playlistId) {
        await loadPlaylist(playlistId);
      }

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Get user playlists
  Future<List<PlaylistModel>> getUserPlaylists({int limit = 20, int offset = 0}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final playlists = await _playlistService.getUserPlaylists(limit: limit, offset: offset);
      state = state.copyWith(isLoading: false);
      return playlists;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return [];
    }
  }

  /// Get featured playlists
  Future<List<PlaylistModel>> getFeaturedPlaylists({int limit = 20, int offset = 0}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final playlists = await _playlistService.getFeaturedPlaylists(limit: limit, offset: offset);
      state = state.copyWith(isLoading: false);
      return playlists;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return [];
    }
  }

  /// Add tracks to a playlist
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int? position,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _playlistService.addTracksToPlaylist(
        playlistId: playlistId,
        trackIds: trackIds,
        position: position ?? 0,
      );

      // Reload the playlist tracks if update was successful and it's the selected playlist
      if (success && state.selectedPlaylist?.id == playlistId) {
        await loadPlaylistTracks(playlistId);
      }

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Follow a playlist
  Future<bool> followPlaylist(String playlistId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final success = await _playlistService.followPlaylist(playlistId);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Unfollow a playlist
  Future<bool> unfollowPlaylist(String playlistId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final success = await _playlistService.unfollowPlaylist(playlistId);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  /// Clear the current playlist selection
  void clearSelection() {
    state = state.copyWith(selectedPlaylist: null, playlistTracks: null);
  }

  /// Reset the playlist state
  void reset() {
    state = const PlaylistStateData();
  }
}
