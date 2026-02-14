import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays additional album information
class AlbumInfo extends StatelessWidget {
  /// The album to display information for
  final AlbumModel album;

  /// Creates a new album info widget
  const AlbumInfo({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.album_details,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildInfoRow(context, l10n.release_date, album.releaseDate?.toString() ?? l10n.unknown_release_date),
        _buildInfoRow(context, l10n.tracks, l10n.songs_count(album.totalTracks)),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
