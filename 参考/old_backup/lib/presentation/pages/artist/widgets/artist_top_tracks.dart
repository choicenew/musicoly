import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';

/// Widget that displays the top tracks of an artist
class ArtistTopTracks extends StatelessWidget {
  /// The artist whose top tracks to display
  final ArtistModel artist;

  /// Creates a new artist top tracks widget
  const ArtistTopTracks({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 实际应从数据层获取，这里保持示例代码
    final List<TrackModel> tracks = [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          'Popular Tracks',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Track list
        if (tracks.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.music_off,
                    size: 48,
                    color: theme.colorScheme.onSurface.withAlpha(128),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tracks available',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                tracks.length > 5 ? 5 : tracks.length, // Show only top 5 tracks
            itemBuilder: (context, index) {
              final track = tracks[index];
              return TrackTile(
                track: track,
                onTap: () {
                  final player = Provider.of<PlayerStateNotifier>(context, listen: false);
                  player.play(
                    trackId: track.id,
                    sourceId: artist.id,
                    sourceName: artist.name,
                  );
                },
              );
            },
          ),

        // 查看全部按钮
        if (tracks.length > 5)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(title: Text('${artist.name} - All Tracks')),
                        body: ListView.builder(
                          itemCount: tracks.length,
                          itemBuilder: (context, index) => TrackTile(
                            track: tracks[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('See All Tracks'),
              ),
            ),
          ),
      ],
    );
  }
}
