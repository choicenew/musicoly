import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/album_model.dart';

/// A reusable card widget for displaying album information
class AlbumCard extends StatelessWidget {
  /// The album data to display
  final AlbumModel album;

  /// Callback when the album card is tapped
  final VoidCallback? onTap;

  /// Whether to show the album name
  final bool showName;

  /// Whether to show the artist name
  final bool showArtist;

  /// Width of the card
  final double? width;

  /// Height of the card
  final double? height;

  const AlbumCard({
    super.key,
    required this.album,
    this.onTap,
    this.showName = true,
    this.showArtist = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  album.imageUrl != null
                      ? album.imageUrl!
                      : 'assets/album-placeholder.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/album-placeholder.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            if (showName) ...[
              const SizedBox(height: 8),
              Text(
                album.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            if (showArtist && album.artistNames.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                album.artistNames.join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withAlpha(
                      ((theme.textTheme.bodySmall?.color?.a ?? 255) * 0.7)
                          .round()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
