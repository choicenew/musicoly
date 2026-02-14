import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';

/// A widget that displays the current playback queue
class PlayerQueue extends StatelessWidget {
  /// List of tracks in the queue
  final List<TrackModel> tracks;

  /// Index of the currently playing track
  final int currentIndex;

  /// Callback when a track in the queue is tapped
  final Function(int index)? onTrackTap;

  /// Callback when a track is reordered in the queue
  final Function(int oldIndex, int newIndex)? onReorder;

  /// Callback when a track is removed from the queue
  final Function(int index)? onRemove;

  const PlayerQueue({
    super.key,
    required this.tracks,
    this.currentIndex = 0,
    this.onTrackTap,
    this.onReorder,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (tracks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.queue_is_empty,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.add_tracks_to_get_started,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.queue,
                style: theme.textTheme.titleLarge,
              ),
              Text(
                l10n.queue_count(tracks.length),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: tracks.length,
            onReorder: (oldIndex, newIndex) {
              if (onReorder != null) {
                // Adjust the index if moving down
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                onReorder!(oldIndex, newIndex);
              }
            },
            itemBuilder: (context, index) {
              final track = tracks[index];
              final isPlaying = index == currentIndex;

              return Dismissible(
                key: Key('queue-track-${track.id}-$index'),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  onRemove?.call(index);
                },
                child: TrackTile(
                  key: Key('track-tile-$index'),
                  track: track,
                  isPlaying: isPlaying,
                  onTap: () => onTrackTap?.call(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
