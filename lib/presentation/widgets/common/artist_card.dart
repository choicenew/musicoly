import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/artist_model.dart';

/// A reusable card widget for displaying artist information
class ArtistCard extends StatelessWidget {
  /// The artist data to display
  final ArtistModel artist;

  /// Callback when the artist card is tapped
  final VoidCallback? onTap;

  /// Whether to show the artist name
  final bool showName;

  /// Width of the card
  final double? width;

  /// Height of the card
  final double? height;

  const ArtistCard({
    super.key,
    required this.artist,
    this.onTap,
    this.showName = true,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipOval(
                child: Image.network(
                  artist.imageUrl ?? 'assets/user-placeholder.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/user-placeholder.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            if (showName) ...[
              const SizedBox(height: 8),
              Text(
                artist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
