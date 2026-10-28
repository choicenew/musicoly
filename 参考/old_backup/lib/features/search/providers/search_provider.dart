import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/providers/search_provider.dart' as base;
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/album_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';
import 'package:pyro_music/core/base/services/search_service.dart';
import '../services/search_service_impl.dart';

/// Provider for the search service implementation
final searchServiceProvider = Provider<SearchServiceImpl>((ref) {
  // Get platform-specific search services from their respective providers
  // This is a placeholder - actual implementation would get services from platform providers
  final platformServices = <SearchService>[];

  return SearchServiceImpl(platformServices: platformServices);
});

/// Search state data class
class SearchStateData {
  /// The current search query
  final String query;

  /// Whether a search is currently in progress
  final bool isSearching;

  /// The current search results
  final SearchResults? results;

  /// Any error that occurred during the search
  final Object? error;

  /// Create a new search state
  const SearchStateData({
    this.query = '',
    this.isSearching = false,
    this.results,
    this.error,
  });

  /// Create a copy of this state with some fields replaced
  SearchStateData copyWith({
    String? query,
    bool? isSearching,
    SearchResults? results,
    Object? error,
  }) {
    return SearchStateData(
      query: query ?? this.query,
      isSearching: isSearching ?? this.isSearching,
      results: results ?? this.results,
      error: error,
    );
  }
}

/// Provider for search state
final searchStateProvider =
    StateNotifierProvider<SearchNotifier, SearchStateData>((ref) {
  final searchService = ref.watch(searchServiceProvider);
  return SearchNotifier(searchService);
});

/// Notifier for search state
class SearchNotifier extends StateNotifier<SearchStateData> {
  /// The search service to use
  final SearchServiceImpl _searchService;

  /// Create a new search notifier
  SearchNotifier(this._searchService) : super(const SearchStateData());

  /// Update the search query without performing a search
  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  /// Perform a search with the current query
  Future<void> search({int limit = 20, int offset = 0}) async {
    if (state.query.isEmpty) return;

    state = state.copyWith(isSearching: true, error: null);

    try {
      final results = await _searchService.search(state.query,
          limit: limit, offset: offset);
      state = state.copyWith(isSearching: false, results: results);
    } catch (e) {
      state = state.copyWith(isSearching: false, error: e);
    }
  }

  /// Get search suggestions for the current query
  Future<List<String>> getSuggestions({int limit = 5}) async {
    if (state.query.isEmpty) return [];

    try {
      return await _searchService.getSearchSuggestions(state.query,
          limit: limit);
    } catch (e) {
      return [];
    }
  }

  /// Clear the current search results
  void clearResults() {
    state = const SearchStateData();
  }
}

/// Implementation of the base search provider
class SearchProviderImpl extends base.SearchProvider {
  /// The search service implementation
  final SearchServiceImpl _searchServiceImpl;

  /// Create a new search provider implementation
  SearchProviderImpl(this._searchServiceImpl) : super();

  @override
  SearchService get service => _searchServiceImpl;
}

/// Provider for the search provider implementation
final searchProviderImplProvider = Provider<SearchProviderImpl>((ref) {
  final searchService = ref.watch(searchServiceProvider);
  return SearchProviderImpl(searchService);
});
