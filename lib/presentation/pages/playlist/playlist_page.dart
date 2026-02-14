import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_header.dart';
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_tracks_list.dart';
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_info.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';

/// The playlist details page
class PlaylistPage extends ConsumerStatefulWidget {
  /// The ID of the playlist to display
  final String playlistId;

  const PlaylistPage({
    super.key,
    required this.playlistId,
  });

  @override
  ConsumerState<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playlistProvider.notifier).loadPlaylist(widget.playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playlistProvider);
    final playlist = state.selectedPlaylist;

    if (state.isLoading && playlist == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (playlist == null) {
      return _buildErrorState(context);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PlaylistHeader(playlist: playlist),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PlaylistInfo(playlist: playlist),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PlaylistTracksList(
                tracks: state.playlistTracks ?? [],
                playlistId: widget.playlistId,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music_outlined,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.playlist_not_found,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.something_went_wrong,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.previous),
            ),
          ],
        ),
      ),
    );
  }
}
