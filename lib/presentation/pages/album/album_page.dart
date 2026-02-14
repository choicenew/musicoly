import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
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

  Future<AlbumModel?> _fetchAlbum() async {
    // Simulate loading delay and fetching album
    await Future.delayed(const Duration(seconds: 2));
    // Return null to simulate "not found", or return an AlbumModel instance for success
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: FutureBuilder<AlbumModel?>(
        future: _fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator(text: l10n.loading_album);
          }
          final album = snapshot.data;
          if (album == null) {
            return _buildErrorState(context);
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AlbumHeader(album: album),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AlbumInfo(album: album),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: AlbumTracks(tracks: []),
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
