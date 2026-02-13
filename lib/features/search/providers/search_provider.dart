import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/base/providers/search_provider.dart';
import 'package:pyro_music/core/base/providers/base_provider.dart';
import 'package:pyro_music/core/base/services/search_service.dart';
import '../services/search_service_impl.dart';

part 'search_provider.freezed.dart';
part 'search_provider.g.dart';

/// Provider for the search service implementation
@Riverpod(keepAlive: true)
SearchServiceImpl searchService(Ref ref) {
  // Get platform-specific search services from their respective providers
  // This is a placeholder - actual implementation would get services from platform providers
  final platformServices = <SearchService>[];

  return SearchServiceImpl(platformServices: platformServices);
}

/// Search state data class
@freezed
abstract class SearchStateData with _$SearchStateData {
  const factory SearchStateData({
    @Default('') String query,
    @Default(false) bool isSearching,
    SearchResults? results,
    Object? error,
  }) = _SearchStateData;
}

/// Notifier for search state
@Riverpod(keepAlive: true)
class SearchNotifier extends _$SearchNotifier with BaseProviderMixin<SearchService>, SearchProviderMixin {
  late final SearchServiceImpl _searchService;

  @override
  SearchStateData build() {
    _searchService = ref.watch(searchServiceProvider);
    initializeService(_searchService, (state) {});
    return const SearchStateData();
  }

  @override
  Future<void> initializeService(SearchService service, void Function(AsyncValue<SearchService?>) updateState) async {
      await super.initializeService(service, updateState);
  }

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

// SearchProviderImpl class removed as it's no longer needed with Riverpod 3 + Mixins
