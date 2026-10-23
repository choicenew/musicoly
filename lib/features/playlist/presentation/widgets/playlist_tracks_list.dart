import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class PlaylistTracksList extends ConsumerWidget {
  final List<TrackInterface> tracks;
  final String playlistId;

  const PlaylistTracksList({
    super.key,
    required this.tracks,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final l10n = AppLocalizations.of(context);

    if (tracks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(l10n.no_tracks),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final trackInterface = tracks[index];
        final track = TrackModel.fromInterface(trackInterface);
        final isPlaying = playerState.currentTrackId == track.id;
        
        return TrackTile(
          track: track,
          isPlaying: isPlaying,
          onTap: () {
            ref.read(playbackStateProvider.notifier).playTracks(
              tracks.map((t) => t.id).toList(),
              initialIndex: index,
            );
          },
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'remove') {
                final success = await ref
                    .read(playlistProvider.notifier)
                    .removeTracksFromPlaylist(
                      playlistId: playlistId,
                      trackIds: [track.id],
                    );
                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.removed_from_playlist)),
                  );
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'remove',
                child: Row(
                  children: [
                    const Icon(Icons.playlist_remove, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.remove_from_playlist),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
