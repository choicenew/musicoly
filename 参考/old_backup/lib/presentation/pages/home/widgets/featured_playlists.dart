import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/playlist_model.dart';
import 'package:pyro_music/presentation/widgets/common/playlist_card.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// A widget that displays featured playlists on the home page
class FeaturedPlaylists extends StatelessWidget {
  const FeaturedPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This would normally come from a provider
    final bool isLoading = false;
    final List<PlaylistModel> playlists =
        []; // Would come from playlist provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Playlists',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to see all featured playlists
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (isLoading) ...[
          const LoadingIndicator(text: 'Loading playlists...'),
        ] else if (playlists.isEmpty) ...[
          _buildEmptyState(theme),
        ] else ...[
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 160,
                    child: PlaylistCard(
                      playlist: playlist,
                      onTap: () {
                        // Navigate to playlist details
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.playlist_play,
            size: 48,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No featured playlists available',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
