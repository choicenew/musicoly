import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays detailed playlist information
class PlaylistInfo extends StatelessWidget {
  /// The playlist to display information for
  final PlaylistModel playlist;

  /// Creates a new playlist info widget
  const PlaylistInfo({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description (if available)
        if (playlist.description != null &&
            playlist.description!.isNotEmpty) ...[
          Text(
            l10n.description,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            playlist.description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Playlist details section title
        Text(
          l10n.details,
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
                icon: Icons.person_outline,
                title: l10n.founder,
                value: playlist.ownerName!,
              ),

            // Privacy status
            _buildInfoItem(
              context,
              icon: Icons.visibility_outlined,
              title: l10n.public,
              value: playlist.isPublic ? l10n.done : l10n.none,
            ),

            // Collaborative status
            _buildInfoItem(
              context,
              icon: Icons.group_outlined,
              title: l10n.collaborative,
              value: playlist.isCollaborative ? l10n.done : l10n.none,
            ),

            // Total tracks
            _buildInfoItem(
              context,
              icon: Icons.music_note_outlined,
              title: l10n.tracks,
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
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
