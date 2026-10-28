import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/track_interface.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Album cover
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              album.imageUrl ?? 'assets/album-placeholder.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 180,
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.album, size: 80),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Album name
          Text(
            album.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Artist name
          Text(
            album.artistNames.join(', '),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Play button
          ElevatedButton.icon(
            onPressed: () {
              if (tracks.isNotEmpty) {
                ref.read(playbackStateProvider.notifier).playTracks(
                  tracks.map((t) => t.id).toList(),
                );
              }
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
}
