import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/favorites/services/favorites_service.dart';

part 'favorites_provider.freezed.dart';
part 'favorites_provider.g.dart';

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService();
});

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default([]) List<TrackModel> favoriteTracks,
    @Default(false) bool isLoading,
    String? error,
  }) = _FavoritesState;
}

@Riverpod(keepAlive: true)
class FavoritesNotifier extends _$FavoritesNotifier {
  late final FavoritesService _service;

  @override
  FavoritesState build() {
    _service = ref.watch(favoritesServiceProvider);
    loadFavorites();
    return const FavoritesState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final tracks = await _service.getFavoriteTracks();
      state = state.copyWith(
        favoriteTracks: tracks,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> toggleFavorite(String trackId) async {
    final result = await _service.toggleFavorite(trackId);
    await loadFavorites();
    return result;
  }
}
