import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// A widget that displays recently played tracks on the home page
class RecentTracks extends StatelessWidget {
  const RecentTracks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This would normally come from a provider
    final bool isLoading = false;
    final List<TrackModel> tracks =
        []; // Would come from player history provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Played',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to see all recent tracks
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (isLoading) ...[
          const LoadingIndicator(text: 'Loading recent tracks...'),
        ] else if (tracks.isEmpty) ...[
          _buildEmptyState(theme),
        ] else ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                tracks.length > 5 ? 5 : tracks.length, // Show max 5 tracks
            itemBuilder: (context, index) {
              final track = tracks[index];

              return TrackTile(
                track: track,
                onTap: () {
                  // Play this track
                },
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No recently played tracks',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Start listening to see your history here',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
