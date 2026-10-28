import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';

/// Widget that displays the playlist header with cover art and basic info
class PlaylistHeader extends ConsumerWidget {
  /// The playlist to display
  final PlaylistModel playlist;

  /// Creates a new playlist header widget
  const PlaylistHeader({super.key, required this.playlist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showPlaylistOptions(context, ref);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Playlist cover and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Playlist cover
              Hero(
                tag: 'playlist_art_${playlist.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: playlist.imageUrl != null
                      ? Image.network(
                          playlist.imageUrl!,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
              ),
              const SizedBox(width: 16),

              // Playlist info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    if (playlist.ownerName != null)
                      Text(
                        l10n.by_author(playlist.ownerName!),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.track_count(playlist.totalTracks),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Play/Shuffle actions
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _playPlaylist(ref, shuffle: false),
                  icon: const Icon(Icons.play_arrow),
                  label: Text(l10n.play_all),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _playPlaylist(ref, shuffle: true),
                  icon: const Icon(Icons.shuffle),
                  label: Text(l10n.shuffle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPlaylistOptions(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(l10n.edit_playlist),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement edit playlist dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: Text(
                l10n.delete_playlist,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.delete_playlist),
                    content: Text(l10n.delete_playlist_confirm(playlist.name)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                        child: Text(l10n.delete),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  final success = await ref
                      .read(playlistProvider.notifier)
                      .deletePlaylist(playlist.id);
                  if (success && context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        )
      ),
    );
  }

  void _playPlaylist(WidgetRef ref, {required bool shuffle}) {
    final state = ref.read(playlistProvider);
    final tracks = state.playlistTracks;
    if (tracks != null && tracks.isNotEmpty) {
      final trackIds = tracks.map((t) => t.id).toList();
      if (shuffle) {
        trackIds.shuffle();
      }
      ref.read(playbackStateProvider.notifier).playTracks(trackIds, initialIndex: 0);
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 140,
      height: 140,
      color: Colors.grey[800],
      child: const Icon(Icons.music_note, size: 64, color: Colors.white54),
    );
  }
}
