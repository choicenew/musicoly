import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/models/playback_state.dart';

/// RetroMusic Style Car Mode (驾驶安全超大按钮模式)
class CarModePage extends ConsumerWidget {
  const CarModePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final playbackState = ref.watch(playbackStateProvider);
    final track = playerState.currentTrack;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('🚗 驾驶车载模式 (Car Mode)'),
        leading: IconButton(
          icon: const Icon(Icons.close, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 专辑封面
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: 220,
                height: 220,
                child: track?.imageUrl != null
                    ? CachedNetworkImage(imageUrl: track!.imageUrl!, fit: BoxFit.cover)
                    : Container(color: Colors.grey.shade900, child: const Icon(Icons.music_note, size: 80, color: Colors.white54)),
              ),
            ),
            const SizedBox(height: 36),

            // 歌曲信息
            Text(
              track?.name ?? '暂无播放曲目',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              track?.artistNames.join(', ') ?? 'Unknown Artist',
              style: const TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 60),

            // 超大触控播放控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 64,
                  color: Colors.white,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () => ref.read(playbackStateProvider.notifier).previous(),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 76,
                    color: Colors.white,
                    icon: Icon(
                      playbackState.playbackState == PlaybackState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: () {
                      if (playbackState.playbackState == PlaybackState.playing) {
                        ref.read(playbackStateProvider.notifier).pause();
                      } else {
                        ref.read(playbackStateProvider.notifier).resume();
                      }
                    },
                  ),
                ),
                IconButton(
                  iconSize: 64,
                  color: Colors.white,
                  icon: const Icon(Icons.skip_next),
                  onPressed: () => ref.read(playbackStateProvider.notifier).next(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
