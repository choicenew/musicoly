import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/local_music/providers/multi_select_provider.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';
import 'package:pyro_music/features/local_music/presentation/local_music_page.dart';
import 'package:pyro_music/presentation/widgets/dialogs/tag_editor_dialog.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// A reusable widget for displaying a track item in lists
class TrackTile extends ConsumerWidget {
  /// The track data to display
  final TrackModel track;

  /// Callback when the track is tapped
  final VoidCallback? onTap;

  /// Callback when the track is played
  final VoidCallback? onPlay;

  /// Whether this track is currently playing
  final bool isPlaying;

  /// Whether to show the album art
  final bool showAlbumArt;

  /// Whether to show artist name
  final bool showArtist;

  /// Whether to show album name
  final bool showAlbum;

  /// Whether to show track duration
  final bool showDuration;

  /// Whether to show track options menu
  final bool showOptions;

  /// Optional trailing widget to override the default options menu
  final Widget? trailing;

  const TrackTile({
    super.key,
    required this.track,
    this.onTap,
    this.onPlay,
    this.isPlaying = false,
    this.showAlbumArt = true,
    this.showArtist = true,
    this.showAlbum = false,
    this.showDuration = true,
    this.showOptions = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedItems = ref.watch(multiSelectProvider);
    final isSelected = selectedItems.contains(track.id);
    final isSelectionMode = selectedItems.isNotEmpty;

    return ListTile(
      onTap: isSelectionMode 
        ? () => ref.read(multiSelectProvider.notifier).toggle(track.id)
        : onTap,
      onLongPress: () => ref.read(multiSelectProvider.notifier).toggle(track.id),
      selected: isSelected || isPlaying,
      selectedTileColor: theme.colorScheme.primaryContainer.withAlpha(0x33),
      leading: isSelectionMode 
        ? Checkbox(
            value: isSelected,
            onChanged: (_) => ref.read(multiSelectProvider.notifier).toggle(track.id),
          )
        : (showAlbumArt ? _buildLeading() : null),
      title: Text(
        track.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
          color: isPlaying ? theme.colorScheme.primary : null,
        ),
      ),
      subtitle: showArtist ? _buildSubtitle() : null,
      trailing: trailing ?? _buildTrailing(context, ref),
    );
  }

  Widget _buildLeading() {
    return SizedBox(
      width: 48,
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          track.imageUrl ?? 'assets/album-placeholder.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset(
            'assets/album-placeholder.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    final artistNames = track.artistNames.join(', ');
    final albumName = track.albumName;

    if (showAlbum) {
      return Text(
        '$artistNames • $albumName',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Text(
      artistNames,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final playlistService = ref.read(playlistServiceProvider);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            track.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: track.isFavorite ? Colors.red : null,
            size: 20,
          ),
          onPressed: () async {
            await playlistService.toggleFavorite(track.id);
          },
        ),
        if (showDuration)
          Text(
            _formatDuration(Duration(milliseconds: track.durationMs)),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        if (showOptions)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'edit_tags') {
                showDialog(
                  context: context,
                  builder: (context) => TagEditorDialog(track: track),
                );
              } else if (value == 'add_to_playlist') {
                final playlistId = await LocalMusicPage.showPlaylistSelectionDialog(context, ref);
                if (playlistId != null) {
                  final success = await playlistService.addTracksToPlaylist(
                    playlistId: playlistId,
                    trackIds: [track.id],
                  );
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.added_to_playlist)),
                    );
                  }
                }
              }
            },
            itemBuilder: (context) => [
              if (track.localPath != null)
                PopupMenuItem(
                  value: 'edit_tags',
                  child: Row(
                    children: [
                      const Icon(Icons.edit_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text(l10n.edit_tags),
                    ],
                  ),
                ),
              PopupMenuItem(
                value: 'add_to_playlist',
                child: Row(
                  children: [
                    const Icon(Icons.playlist_add, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.add_to_playlist),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    const Icon(Icons.share_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.share),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
