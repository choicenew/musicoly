import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
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
            style: theme.textTheme.bodyLarge,
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final trackInterface = tracks[index];
          final track = TrackModel.fromInterface(trackInterface);

          return TrackTile(
            track: track,
            onTap: () {
              ref.read(playbackStateProvider.notifier).playTracks(
                tracks.map((t) => t.id).toList(),
                initialIndex: index,
              );
            },
          );
        },
        childCount: tracks.length,
      ),
    );
  }
}
