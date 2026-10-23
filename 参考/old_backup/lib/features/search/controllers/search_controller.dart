import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/album_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';
import 'package:pyro_music/core/base/services/search_service.dart';
import '../providers/search_provider.dart';

/// Controller for search functionality
///
/// Handles user interactions related to searching
class SearchController {
  /// The ref to access providers
  final Ref _ref;

  /// Create a new search controller
  SearchController(this._ref);

  /// Get the current search state
  SearchStateData get state => _ref.read(searchStateProvider);

  /// Get the search state notifier
  SearchNotifier get _notifier => _ref.read(searchStateProvider.notifier);

  /// Update the search query without performing a search
  void updateQuery(String query) {
    _notifier.updateQuery(query);
  }

  /// Perform a search with the current query
  Future<void> search({int limit = 20, int offset = 0}) async {
    await _notifier.search(limit: limit, offset: offset);
  }

  /// Get search suggestions for the current query
  Future<List<String>> getSuggestions({int limit = 5}) async {
    return await _notifier.getSuggestions(limit: limit);
  }

  /// Clear the current search results
  void clearResults() {
    _notifier.clearResults();
  }

  /// Search for tracks matching the query
  Future<List<TrackInterface>> searchTracks(String query,
      {int limit = 20, int offset = 0}) async {
    final provider = _ref.read(searchProviderImplProvider);
    final result =
        await provider.searchTracks(query, limit: limit, offset: offset);
    return result.when(
      data: (data) => data,
      error: (_, __) => [],
      loading: () => [],
    );
  }

  /// Search for albums matching the query
  Future<List<AlbumInterface>> searchAlbums(String query,
      {int limit = 20, int offset = 0}) async {
    final provider = _ref.read(searchProviderImplProvider);
    final result =
        await provider.searchAlbums(query, limit: limit, offset: offset);
    return result.when(
      data: (data) => data,
      error: (_, __) => [],
      loading: () => [],
    );
  }

  /// Search for artists matching the query
  Future<List<ArtistInterface>> searchArtists(String query,
      {int limit = 20, int offset = 0}) async {
    final provider = _ref.read(searchProviderImplProvider);
    final result =
        await provider.searchArtists(query, limit: limit, offset: offset);
    return result.when(
      data: (data) => data,
      error: (_, __) => [],
      loading: () => [],
    );
  }

  /// Search for playlists matching the query
  Future<List<PlaylistInterface>> searchPlaylists(String query,
      {int limit = 20, int offset = 0}) async {
    final provider = _ref.read(searchProviderImplProvider);
    final result =
        await provider.searchPlaylists(query, limit: limit, offset: offset);
    return result.when(
      data: (data) => data,
      error: (_, __) => [],
      loading: () => [],
    );
  }

  /// Search across all media types
  Future<SearchResults?> searchAll(String query,
      {int limit = 20, int offset = 0}) async {
    final provider = _ref.read(searchProviderImplProvider);
    
    // Use searchAll instead of search
    final result = await provider.searchAll(query, limit: limit, offset: offset);
    
    return result.when(
      data: (data) {
        // Convert the Map to a SearchResults object
        return SearchResults(
          tracks: (data['tracks'])?.cast<TrackInterface>() ?? [],
          albums: (data['albums'])?.cast<AlbumInterface>() ?? [],
          artists: (data['artists'])?.cast<ArtistInterface>() ?? [],
          playlists: (data['playlists'])?.cast<PlaylistInterface>() ?? [],
        );
        // The line below is unreachable and should be removed
      },
      error: (_, __) => null,
      loading: () => null,
    );
  }

  /// Provider for the search controller
  static final provider = Provider.autoDispose<SearchController>((ref) {
    return SearchController(ref);
  });
}
