import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'search_provider.freezed.dart';
part 'search_provider.g.dart';

/// Search state data class
@freezed
abstract class SearchStateData with _$SearchStateData {
  const factory SearchStateData({
    @Default('') String query,
    @Default(false) bool isSearching,
    @Default([]) List<SourceInfo> results,
    Object? error,
  }) = _SearchStateData;
}

/// Notifier for search state
@Riverpod(keepAlive: true)
class SearchNotifier extends _$SearchNotifier {
  late final TrackSourceManager _trackSourceManager;

  @override
  SearchStateData build() {
    final registry = ServiceRegistry();
    _trackSourceManager =
        registry.getService<TrackSourceManager>('track_source_manager')!;
    return const SearchStateData();
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
      final results = await _trackSourceManager.search(state.query);
      state = state.copyWith(isSearching: false, results: results);
    } catch (e) {
      state = state.copyWith(isSearching: false, error: e);
    }
  }

  /// Clear the current search results
  void clearResults() {
    state = const SearchStateData();
  }
}
