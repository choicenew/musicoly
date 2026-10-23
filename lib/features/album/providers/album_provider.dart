import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/album/services/album_service.dart';

part 'album_provider.freezed.dart';
part 'album_provider.g.dart';

final albumServiceProvider = Provider<AlbumService>((ref) {
  return AlbumService();
});

@freezed
abstract class AlbumState with _$AlbumState {
  const factory AlbumState({
    AlbumModel? currentAlbum,
    @Default([]) List<TrackModel> albumTracks,
    @Default(false) bool isLoading,
    String? error,
  }) = _AlbumState;
}

@Riverpod(keepAlive: true)
class AlbumNotifier extends _$AlbumNotifier {
  late final AlbumService _service;

  @override
  AlbumState build() {
    _service = ref.watch(albumServiceProvider);
    return const AlbumState();
  }

  Future<void> loadAlbum(String albumId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final album = await _service.getAlbum(albumId);
      final tracks = await _service.getAlbumTracks(albumId);
      state = state.copyWith(
        currentAlbum: album,
        albumTracks: tracks,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
