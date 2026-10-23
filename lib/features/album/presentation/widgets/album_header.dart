import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays the album header with cover art and basic info
class AlbumHeader extends ConsumerWidget {
  /// The album to display
  final AlbumModel album;

  /// The tracks in this album
  final List<TrackInterface> tracks;

  /// Creates a new album header widget
  const AlbumHeader({super.key, required this.album, required this.tracks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album cover and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  album.imageUrl ?? 'assets/album-placeholder.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 160,
                      height: 160,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.album, size: 80),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Album info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Album type
                    Text(
                      album.albumType?.toUpperCase() ?? l10n.album.toUpperCase(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Album name
                    Text(
                      album.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Artists
                    Text(
                      album.artistNames.join(', '),
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    // Play button
                    ElevatedButton.icon(
                      onPressed: tracks.isEmpty ? null : () {
                        final trackIds = tracks.map((t) => t.id).toList();
                        ref.read(playbackStateProvider.notifier).playTracks(trackIds);
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
