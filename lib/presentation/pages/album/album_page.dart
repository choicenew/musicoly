import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/pages/album/widgets/album_header.dart';
import 'package:pyro_music/presentation/pages/album/widgets/album_tracks.dart';
import 'package:pyro_music/presentation/pages/album/widgets/album_info.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// The album details page
class AlbumPage extends StatelessWidget {
  /// The ID of the album to display
  final String albumId;

  const AlbumPage({
    super.key,
    required this.albumId,
  });

  Future<(AlbumModel?, List<TrackInterface>)> _fetchAlbumAndTracks() async {
    final isar = GetIt.instance<Isar>();
    final tracks = await isar.trackEntitys
        .filter()
        .albumIdEqualTo(albumId)
        .findAll();

    if (tracks.isEmpty) return (null, <TrackInterface>[]);

    // Convert TrackEntity to TrackInterface (TrackModel)
    final trackModels = tracks.map((t) => TrackModel(
      id: t.trackId,
      platform: t.platform,
      name: t.name,
      imageUrl: t.imageUrl,
      artistIds: t.artistIds ?? [],
      artistNames: t.artistNames ?? [],
      albumId: t.albumId,
      albumName: t.albumName,
      durationMs: t.durationMs,
      localPath: t.localPath,
      isFavorite: t.isFavorite,
    )).toList();

    // Create AlbumModel from first track
    final firstTrack = tracks.first;
    final album = AlbumModel(
      id: firstTrack.albumId ?? albumId,
      platform: firstTrack.platform,
      name: firstTrack.albumName ?? 'Unknown Album',
      imageUrl: firstTrack.imageUrl,
      artistIds: firstTrack.artistIds ?? [],
      artistNames: firstTrack.artistNames ?? [],
      totalTracks: tracks.length,
      albumType: 'album',
    );

    return (album, trackModels);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: FutureBuilder<(AlbumModel?, List<TrackInterface>)>(
        future: _fetchAlbumAndTracks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator(text: l10n.loading_album);
          }
          final (album, tracks) = snapshot.data ?? (null, <TrackInterface>[]);
          if (album == null) {
            return _buildErrorState(context);
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AlbumHeader(album: album, tracks: tracks),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AlbumInfo(album: album),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AlbumTracks(tracks: tracks),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.album_outlined,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.album_not_found,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.album_not_found_hint,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(l10n.go_back),
          ),
        ],
      ),
    );
  }
}
