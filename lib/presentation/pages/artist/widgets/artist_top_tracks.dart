import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';

/// Widget that displays the top tracks of an artist
class ArtistTopTracks extends ConsumerWidget {
  /// The artist whose top tracks to display
  final ArtistModel artist;

  /// Creates a new artist top tracks widget
  const ArtistTopTracks({super.key, required this.artist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // 实际应从数据层获取，这里保持示例代码
    final List<TrackModel> tracks = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          l10n.popular_tracks,
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.no_tracks_available,
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
                  ref.read(playerStateProvider.notifier).play(
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
                        appBar:
                            AppBar(title: Text('${artist.name} - ${l10n.all_tracks}')),
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
                child: Text(l10n.see_all_tracks),
              ),
            ),
          ),
      ],
    );
  }
}
