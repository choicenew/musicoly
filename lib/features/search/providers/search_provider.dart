import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

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
  late final Isar _isar;

  @override
  SearchStateData build() {
    final registry = ServiceRegistry();
    _trackSourceManager =
        registry.getService<TrackSourceManager>('track_source_manager')!;
    _isar = GetIt.instance<Isar>();
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
    // 1. Check if track already exists in Isar
    var entity = await _isar.trackEntitys
        .filter()
        .trackIdEqualTo(result.id)
        .findFirst();

    // 2. If not, create and save it
    if (entity == null) {
      entity = TrackEntity()
        ..trackId = result.id
        ..name = result.title
        ..platform = result.sourceId
        ..imageUrl = result.thumbnailUrl
        ..artistNames = [result.artist]
        ..artistIds = []
        ..durationMs = result.duration.inMilliseconds
        ..isPlayable = true
        ..createdAt = DateTime.now();

      await _isar.writeTxn(() async {
        await _isar.trackEntitys.put(entity!);
      });
    }

    // 3. Play the track
    await ref.read(playbackStateProvider.notifier).playTrack(result.id);
  }
}
