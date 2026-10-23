import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';
import 'package:pyro_music/features/player/services/playback_service_impl.dart';
import 'package:pyro_music/features/track_source/services/track_source_manager_impl.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'search_provider.freezed.dart';

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

/// Provider for SearchNotifier
final searchProvider = NotifierProvider<SearchNotifier, SearchStateData>(() {
  return SearchNotifier();
});

/// Notifier for search state
class SearchNotifier extends Notifier<SearchStateData> {
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

  /// Perform a search
  Future<void> search([String? query, int limit = 20, int offset = 0]) async {
    if (query != null) {
      updateQuery(query);
    }

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

  /// Play a search result
  Future<void> playResult(SourceInfo result) async {
    final playbackService =
        ServiceRegistry().getService<PlaybackService>('playback_service');
    if (playbackService != null) {
      await playbackService.playTrack(result.id);
    }
  }
}
