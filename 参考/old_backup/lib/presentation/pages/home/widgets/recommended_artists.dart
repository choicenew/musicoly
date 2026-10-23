import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/presentation/widgets/common/artist_card.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// A widget that displays recommended artists on the home page
class RecommendedArtists extends StatelessWidget {
  const RecommendedArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This would normally come from a provider
    final bool isLoading = false;
    final List<ArtistModel> artists =
        []; // Would come from recommendations provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended Artists',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to see all recommended artists
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (isLoading) ...[
          const LoadingIndicator(text: 'Loading recommendations...'),
        ] else if (artists.isEmpty) ...[
          _buildEmptyState(theme),
        ] else ...[
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: artists.length,
              itemBuilder: (context, index) {
                final artist = artists[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 120,
                    child: ArtistCard(
                      artist: artist,
                      onTap: () {
                        // Navigate to artist details
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
      height: 160,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 48,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No artist recommendations available',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
