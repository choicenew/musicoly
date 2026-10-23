import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/artist/services/artist_service.dart';

part 'artist_provider.freezed.dart';
part 'artist_provider.g.dart';

final artistServiceProvider = Provider<ArtistService>((ref) {
  return ArtistService();
});

@freezed
abstract class ArtistState with _$ArtistState {
  const factory ArtistState({
    ArtistModel? currentArtist,
    @Default([]) List<TrackModel> topTracks,
    @Default([]) List<AlbumModel> albums,
    @Default(false) bool isLoading,
    String? error,
  }) = _ArtistState;
}

@Riverpod(keepAlive: true)
class ArtistNotifier extends _$ArtistNotifier {
  late final ArtistService _service;

  @override
  ArtistState build() {
    _service = ref.watch(artistServiceProvider);
    return const ArtistState();
  }

  Future<void> loadArtist(String artistId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final artist = await _service.getArtist(artistId);
      final topTracks = await _service.getArtistTopTracks(artistId);
      final albums = await _service.getArtistAlbums(artistId);
      state = state.copyWith(
        currentArtist: artist,
        topTracks: topTracks,
        albums: albums,
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
