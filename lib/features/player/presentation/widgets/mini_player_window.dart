import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:pyro_music/core/services/desktop_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// 桌面端迷你播放器组件 (Compact Mini Player for Desktop Mode)
class MiniPlayerWindow extends ConsumerWidget {
  const MiniPlayerWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateNotifierProvider);
    final isPlaying = ref.watch(playbackNotifierProvider);
    final track = playerState.currentTrack;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outlineVariant.withAlpha(100),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Bar with Window Drag Handle & Controls
            Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withAlpha(120),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pyro Music Mini',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_full, size: 16),
                  tooltip: '展开主窗口',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    final desktopService = ServiceRegistry().getService<DesktopService>('desktop_service');
                    desktopService?.toggleMiniPlayer();
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  tooltip: '关闭',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => windowManager.hide(),
                ),
              ],
            ),
            const Spacer(),
            // Main Track Info Row
            Row(
              children: [
                // Artwork
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: track?.albumArtUrl != null && track!.albumArtUrl.isNotEmpty
                      ? Image.network(
                          track.albumArtUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholderArt(colorScheme),
                        )
                      : _buildPlaceholderArt(colorScheme),
                ),
                const SizedBox(width: 12),
                // Title & Artist
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        track?.name ?? '未在播放歌曲',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        track?.artistNames.join(', ') ?? 'Pyro Music',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Controls: Prev, Play/Pause, Next
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded, size: 22),
                  onPressed: () => ref.read(playerStateNotifierProvider.notifier).previousTrack(),
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                    size: 32,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      ref.read(playbackNotifierProvider.notifier).pause();
                    } else if (track != null) {
                      ref.read(playbackNotifierProvider.notifier).resume();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded, size: 22),
                  onPressed: () => ref.read(playerStateNotifierProvider.notifier).nextTrack(),
                ),
              ],
            ),
            const Spacer(),
            // Mini Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: playerState.duration.inMilliseconds > 0
                    ? playerState.position.inMilliseconds / playerState.duration.inMilliseconds
                    : 0.0,
                minHeight: 3,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderArt(ColorScheme colorScheme) {
    return Container(
      width: 48,
      height: 48,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.music_note_rounded,
        color: colorScheme.primary,
      ),
    );
  }
}
