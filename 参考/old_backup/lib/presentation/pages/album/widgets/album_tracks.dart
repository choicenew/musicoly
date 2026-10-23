import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';

/// Widget that displays the tracks in an album
class AlbumTracks extends StatelessWidget {
  /// The album containing the tracks
  final AlbumModel album;

  /// Creates a new album tracks widget
  const AlbumTracks({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // In a real implementation, these tracks would come from a provider
    // This is just a placeholder for demonstration
    final List<TrackModel> tracks = [];
    const bool isLoading = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tracks',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${album.totalTracks} songs',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Track list
        if (tracks.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.music_off,
                    size: 48,
                    color: theme.colorScheme.onSurface.withAlpha(128),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tracks available',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              return TrackTile(
                track: track,
                onTap: () {
                  final player =
                      Provider.of<PlayerStateNotifier>(context, listen: false);
                  // Use the correct play method with required parameters
                  player.play(
                    trackId: track.id,
                    sourceId: album.id,
                    sourceName: album.name,
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
