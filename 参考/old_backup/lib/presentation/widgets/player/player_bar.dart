import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

/// A widget that displays the currently playing track at the bottom of the app
class PlayerBar extends StatelessWidget {
  /// Callback when the player bar is tapped to expand the full player
  final VoidCallback? onTap;

  const PlayerBar({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This would normally come from a provider
    const bool isPlaying = true;
    const TrackModel? currentTrack = null; // Would come from player provider

    // If no track is playing, don't show the player bar
    if (currentTrack == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Album art
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  currentTrack.imageUrl ?? 'assets/album-placeholder.png',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/album-placeholder.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Track info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentTrack.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentTrack.artistNames.join(', '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withAlpha(179),
                    ),
                  ),
                ],
              ),
            ),

            // Playback controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    // Skip to previous track
                  },
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    // Implement play/pause functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    // Skip to next track
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
