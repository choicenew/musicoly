import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/providers/playlist_provider.dart' as base;
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/services/playlist_service.dart';
import '../services/playlist_service_impl.dart';

/// Provider for the playlist service implementation
final playlistServiceProvider = Provider<PlaylistServiceImpl>((ref) {
  // Get platform-specific playlist services from their respective providers
  // This is a placeholder - actual implementation would get services from platform providers
  final platformServices = <PlaylistService>[];

  return PlaylistServiceImpl(platformServices: platformServices);
});

/// Playlist state data class
class PlaylistStateData {
  /// The currently selected playlist
  final PlaylistInterface? selectedPlaylist;

  /// The tracks in the currently selected playlist
  final List<TrackInterface>? playlistTracks;

  /// Whether playlist data is currently loading
  final bool isLoading;

  /// Any error that occurred during playlist operations
  final Object? error;

  /// Create a new playlist state
  const PlaylistStateData({
    this.selectedPlaylist,
    this.playlistTracks,
    this.isLoading = false,
    this.error,
  });

  /// Create a copy of this state with some fields replaced
  PlaylistStateData copyWith({
    PlaylistInterface? selectedPlaylist,
    List<TrackInterface>? playlistTracks,
    bool? isLoading,
    Object? error,
  }) {
    return PlaylistStateData(
      selectedPlaylist: selectedPlaylist ?? this.selectedPlaylist,
      playlistTracks: playlistTracks ?? this.playlistTracks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for playlist state
final playlistStateProvider =
    StateNotifierProvider<PlaylistNotifier, PlaylistStateData>((ref) {
  final playlistService = ref.watch(playlistServiceProvider);
  return PlaylistNotifier(playlistService);
});

/// Notifier for playlist state
class PlaylistNotifier extends StateNotifier<PlaylistStateData> {
  /// The playlist service to use
  final PlaylistServiceImpl _playlistService;

  /// Create a new playlist notifier
  PlaylistNotifier(this._playlistService) : super(const PlaylistStateData());

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

  /// Add tracks to a playlist
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int position = 0,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _playlistService.addTracksToPlaylist(
        playlistId: playlistId,
        trackIds: trackIds,
        position: position,
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
    state = const PlaylistStateData();
  }
}

/// Implementation of the base playlist provider
class PlaylistProviderImpl extends base.PlaylistProvider {
  /// The playlist service implementation
  final PlaylistServiceImpl _playlistServiceImpl;

  /// Create a new playlist provider implementation
  PlaylistProviderImpl(this._playlistServiceImpl) : super();

  @override
  PlaylistService get service => _playlistServiceImpl;
}

/// Provider for the playlist provider implementation
final playlistProviderImplProvider = Provider<PlaylistProviderImpl>((ref) {
  final playlistService = ref.watch(playlistServiceProvider);
  return PlaylistProviderImpl(playlistService);
});
