import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/core/base/models/track_model.dart';

class PlaylistTracksList extends ConsumerWidget {
  const PlaylistTracksList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    // 实际应从播放列表数据中获取曲目列表，这里暂时模拟一些数据
    final tracks = <TrackModel>[]; 

    if (tracks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No tracks in this playlist'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isPlaying = playerState.currentTrackId == track.id;
        
        return TrackTile(
          track: track,
          isPlaying: isPlaying,
          onTap: () {
            ref.read(playerStateProvider.notifier).play(
              trackId: track.id,
            );
          },
        );
      },
    );
  }
}