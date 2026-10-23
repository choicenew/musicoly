import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/playlist_model.dart';

/// Widget that displays detailed playlist information
class PlaylistInfo extends StatelessWidget {
  /// The playlist to display information for
  final PlaylistModel playlist;

  /// Creates a new playlist info widget
  const PlaylistInfo({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description (if available)
        if (playlist.description != null &&
            playlist.description!.isNotEmpty) ...[
          Text(
            'Description',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            playlist.description!,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
        ],

        // Playlist details section title
        Text(
          'Playlist Details',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Playlist details grid
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            // Owner
            if (playlist.ownerName != null)
              _buildInfoItem(
                context,
                icon: Icons.person,
                title: 'Created By',
                value: playlist.ownerName!,
              ),

            // Privacy status
            _buildInfoItem(
              context,
              icon: Icons.visibility,
              title: 'Privacy',
              value: playlist.isPublic ? 'Public' : 'Private',
            ),

            // Collaborative status
            _buildInfoItem(
              context,
              icon: Icons.group,
              title: 'Collaborative',
              value: playlist.isCollaborative ? 'Yes' : 'No',
            ),

            // Total tracks
            _buildInfoItem(
              context,
              icon: Icons.music_note,
              title: 'Tracks',
              value: playlist.totalTracks.toString(),
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
