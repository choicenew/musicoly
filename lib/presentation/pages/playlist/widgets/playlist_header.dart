import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/playlist_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays the playlist header with cover art and basic info
class PlaylistHeader extends StatelessWidget {
  /// The playlist to display
  final PlaylistModel playlist;

  /// Creates a new playlist header widget
  const PlaylistHeader({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Playlist cover and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Playlist cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  playlist.imageUrl ?? 'assets/placeholder.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 160,
                      height: 160,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.queue_music, size: 80),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Playlist info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Playlist type
                    Text(
                      l10n.playlist.toUpperCase(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Playlist name
                    Text(
                      playlist.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Owner name
                    if (playlist.ownerName != null)
                      Text(
                        l10n.by_author(playlist.ownerName!),
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),

                    // Track count
                    Text(
                      l10n.tracks_count(playlist.totalTracks),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),

                    // Play button
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement play functionality
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: Text(l10n.play),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
