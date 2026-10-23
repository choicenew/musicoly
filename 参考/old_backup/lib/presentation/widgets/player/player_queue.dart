import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
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
    Key? key,
    required this.tracks,
    this.currentIndex = 0,
    this.onTrackTap,
    this.onReorder,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (tracks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music,
              size: 64,
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Queue is empty',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add some tracks to get started',
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
                'Queue',
                style: theme.textTheme.titleLarge,
              ),
              Text(
                '${tracks.length} tracks',
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
                  padding: const EdgeInsets.only(right: 16.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) {
                  if (onRemove != null) {
                    onRemove!(index);
                  }
                },
                child: TrackTile(
                  track: track,
                  isPlaying: isPlaying,
                  onTap: () {
                    if (onTrackTap != null) {
                      onTrackTap!(index);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
