import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// Widget that displays the list of tracks in an album
class AlbumTracks extends ConsumerWidget {
  /// The list of tracks to display
  final List<TrackInterface> tracks;

  /// Creates a new album tracks list widget
  const AlbumTracks({super.key, required this.tracks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (tracks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            l10n.no_tracks_available,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tracks list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];
            return ListTile(
              leading: SizedBox(
                width: 32,
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
              title: Text(
                track.name,
                style: theme.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                track.artistNames.join(', '),
                style: theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                _formatDuration(track.durationMs),
                style: theme.textTheme.bodySmall,
              ),
              onTap: () {
                final trackIds = tracks.map((t) => t.id).toList();
                ref.read(playbackStateProvider.notifier).playTracks(trackIds, initialIndex: index);
              },
            );
          },
        ),
      ],
    );
  }

  String _formatDuration(int ms) {
    final minutes = (ms / 60000).floor();
    final seconds = ((ms % 60000) / 1000).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
