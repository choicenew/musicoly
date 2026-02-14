import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays the artist header with image and basic info
class ArtistHeader extends StatelessWidget {
  /// The artist to display
  final ArtistModel artist;

  /// Creates a new artist header widget
  const ArtistHeader({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Artist image
          ClipOval(
            child: Image.network(
              artist.imageUrl ?? 'assets/user-placeholder.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 180,
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.person, size: 80),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Artist name
          Text(
            artist.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Followers count
          if (artist.followersCount != null)
            Text(
              l10n.followers_count(artist.followersCount!),
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 16),

          // Genres
          if (artist.genres != null && artist.genres!.isNotEmpty)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: artist.genres!
                  .map((genre) => _buildGenreChip(context, genre))
                  .toList(),
            ),
          const SizedBox(height: 16),

          // Play button
          ElevatedButton.icon(
            onPressed: () {
              context.read<PlayerService>().play(
                trackId: "", // 需要具体曲目ID
                sourceId: artist.id,
                sourceName: artist.name,
              );
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
    );
  }

  /// Builds a chip for displaying a genre
  Widget _buildGenreChip(BuildContext context, String genre) {
    final theme = Theme.of(context);

    return Chip(
      label: Text(
        genre,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
    );
  }
}
