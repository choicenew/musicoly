import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/playlist_model.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// A reusable card widget for displaying playlist information
class PlaylistCard extends StatelessWidget {
  /// The playlist data to display
  final PlaylistModel playlist;

  /// Callback when the playlist card is tapped
  final VoidCallback? onTap;

  /// Whether to show the playlist name
  final bool showName;

  /// Whether to show the owner name
  final bool showOwner;

  /// Width of the card
  final double? width;

  /// Height of the card
  final double? height;

  const PlaylistCard({
    super.key,
    required this.playlist,
    this.onTap,
    this.showName = true,
    this.showOwner = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  playlist.imageUrl != null
                      ? playlist.imageUrl!
                      : 'assets/playlist-placeholder.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/playlist-placeholder.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            if (showName) ...[
              const SizedBox(height: 8),
              Text(
                playlist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            if (showOwner && playlist.ownerName != null) ...[
              const SizedBox(height: 4),
              Text(
                l10n.by_author(playlist.ownerName ?? l10n.guest),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
