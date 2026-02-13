import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/album_model.dart';

/// Widget that displays detailed album information
class AlbumInfo extends StatelessWidget {
  /// The album to display information for
  final AlbumModel album;

  /// Creates a new album info widget
  const AlbumInfo({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Format release date
    final releaseDate = album.releaseDate;
    final releaseDateText = releaseDate != null
        ? '${releaseDate.year}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}'
        : 'Unknown release date';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Album details section title
        Text(
          'Album Details',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Album details grid
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            // Release date
            _buildInfoItem(
              context,
              icon: Icons.calendar_today,
              title: 'Release Date',
              value: releaseDateText,
            ),

            // Total tracks
            _buildInfoItem(
              context,
              icon: Icons.music_note,
              title: 'Tracks',
              value: album.totalTracks.toString(),
            ),

            // Genres (if available)
            if (album.genres != null && album.genres!.isNotEmpty)
              _buildInfoItem(
                context,
                icon: Icons.category,
                title: 'Genres',
                value: album.genres!.join(', '),
              ),

            // Popularity (if available)
            if (album.popularity != null)
              _buildInfoItem(
                context,
                icon: Icons.trending_up,
                title: 'Popularity',
                value: '${album.popularity}/100',
              ),
          ],
        ),
      ],
    );
  }

  /// Builds an individual info item with icon, title and value
  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
