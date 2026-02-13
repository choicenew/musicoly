import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import '../providers/playlist_provider.dart';

/// Controller for playlist functionality
///
/// Handles user interactions related to playlists
class PlaylistController {
  /// The ref to access providers
  final Ref _ref;

  /// Create a new playlist controller
  PlaylistController(this._ref);

  /// Get the current playlist state
  PlaylistStateData get state => _ref.read(playlistProvider);

  /// Get the playlist state notifier
  PlaylistNotifier get _notifier => _ref.read(playlistProvider.notifier);

  /// Get the playlist provider implementation
  // Using Notifier as it mixes in the provider capabilities
  PlaylistNotifier get _provider => _notifier;

  /// Load a playlist by ID
  Future<void> loadPlaylist(String playlistId) async {
    await _notifier.loadPlaylist(playlistId);
  }

  /// Load tracks for a playlist
  Future<void> loadPlaylistTracks(String playlistId,
      {int limit = 100, int offset = 0}) async {
    await _notifier.loadPlaylistTracks(playlistId,
        limit: limit, offset: offset);
  }

  /// Create a new playlist
  Future<PlaylistInterface?> createPlaylist({
    required String name,
    String? description,
    bool public = false,
    bool collaborative = false,
  }) async {
    return await _notifier.createPlaylist(
      name: name,
      description: description,
      public: public,
      collaborative: collaborative,
    );
  }

  /// Update a playlist's details
  Future<bool> updatePlaylist({
    required String playlistId,
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    return await _notifier.updatePlaylist(
      playlistId: playlistId,
      name: name,
      description: description,
      public: public,
      collaborative: collaborative,
    );
  }

  /// Add tracks to a playlist
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int? position = 0,
  }) async {
    return await _notifier.addTracksToPlaylist(
      playlistId: playlistId,
      trackIds: trackIds,
      position: position,
    );
  }

  /// Remove tracks from a playlist
  Future<bool> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    return await _notifier.removeTracksFromPlaylist(
      playlistId: playlistId,
      trackIds: trackIds,
    );
  }

  /// Follow a playlist
  Future<bool> followPlaylist(String playlistId) async {
    return await _notifier.followPlaylist(playlistId);
  }

  /// Unfollow a playlist
  Future<bool> unfollowPlaylist(String playlistId) async {
    return await _notifier.unfollowPlaylist(playlistId);
  }

  /// Get user playlists
  Future<List<PlaylistInterface>> getUserPlaylists(
      {int limit = 20, int offset = 0}) async {
    return await _provider.getUserPlaylists(limit: limit, offset: offset);
  }

  /// Get featured playlists
  Future<List<PlaylistInterface>> getFeaturedPlaylists(
      {int limit = 20, int offset = 0}) async {
    return await _provider.getFeaturedPlaylists(limit: limit, offset: offset);
  }

  /// Get category playlists
  Future<List<PlaylistInterface>> getCategoryPlaylists(String categoryId,
      {int limit = 20, int offset = 0}) async {
    // Since the provider doesn't have this method yet, we'll implement a workaround
    // by directly accessing the playlist service
    try {
      final playlistService = _ref.read(playlistServiceProvider);
      final playlists = await playlistService.getCategoryPlaylists(
        categoryId,
        limit: limit,
        offset: offset,
      );
      return playlists;
    } catch (e) {
      debugPrint('Error getting category playlists: $e');
      return [];
    }
  }

  /// Clear the current playlist selection
  void clearSelection() {
    _notifier.clearSelection();
  }

  /// Provider for the playlist controller
  static final provider = Provider.autoDispose<PlaylistController>((ref) {
    return PlaylistController(ref);
  });
}
