import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/features/player/providers/queue_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';

class PlayerQueueSheet extends ConsumerWidget {
  const PlayerQueueSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final queueState = ref.watch(queueStateProvider);
    final isar = GetIt.instance<Isar>();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.queue,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    ref.read(queueStateProvider.notifier).clearQueue();
                    Navigator.pop(context);
                  },
                  child: Text(l10n.clear_all),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TrackEntity>>(
              future: _getTracks(isar, queueState.queue),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final tracks = snapshot.data ?? [];
                if (tracks.isEmpty) {
                  return Center(child: Text(l10n.no_tracks));
                }
                
                final currentTrackId = ref.watch(playerStateProvider.select((s) => s.currentTrackId));

                return ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    final isCurrent = track.trackId == currentTrackId;
                    
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: track.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: track.imageUrl!,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 48,
                                height: 48,
                                color: Colors.grey[800],
                                child: const Icon(Icons.music_note),
                              ),
                      ),
                      title: Text(
                        track.name,
                        style: TextStyle(
                          color: isCurrent ? Theme.of(context).colorScheme.primary : null,
                          fontWeight: isCurrent ? FontWeight.bold : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        track.artistNames?.join(', ') ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          ref.read(queueStateProvider.notifier).removeTrack(track.trackId);
                        },
                      ),
                      onTap: () {
                        ref.read(playbackStateProvider.notifier).playTracks(
                          queueState.queue,
                          initialIndex: index,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<TrackEntity>> _getTracks(Isar isar, List<String> trackIds) async {
    final List<TrackEntity> tracks = [];
    for (final id in trackIds) {
      final track = await isar.trackEntitys.filter().trackIdEqualTo(id).findFirst();
      if (track != null) {
        tracks.add(track);
      }
    }
    return tracks;
  }
}
