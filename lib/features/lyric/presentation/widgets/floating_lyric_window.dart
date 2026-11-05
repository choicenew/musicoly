import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/lyric/services/floating_lyrics_service.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// 桌面/系统置顶悬浮歌词条组件 (Floating / Overlay Desktop Lyric Strip)
class FloatingLyricWindow extends ConsumerStatefulWidget {
  const FloatingLyricWindow({super.key});

  @override
  ConsumerState<FloatingLyricWindow> createState() => _FloatingLyricWindowState();
}

class _FloatingLyricWindowState extends ConsumerState<FloatingLyricWindow> {
  bool _isLocked = false;
  bool _showControls = false;

  @override
  Widget build(BuildContext context) {
    final lyricService = ref.watch(floatingLyricsServiceProvider);
    final isPlaying = ref.watch(playbackNotifierProvider);

    if (!lyricService.isEnabled) {
      return const SizedBox.shrink();
    }

    final lyricText = lyricService.currentLyricText.isEmpty
        ? 'Pyro Music 悬浮歌词'
        : lyricService.currentLyricText;
    final translation = lyricService.currentTranslation;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _showControls = true),
      onExit: (_) => setState(() => _showControls = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(_showControls ? 180 : 120),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withAlpha(_showControls ? 60 : 30),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Controls Bar (Shown on hover)
            if (_showControls)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
                        size: 18,
                        color: Colors.white70,
                      ),
                      tooltip: _isLocked ? '解锁位置' : '锁定位置',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => setState(() => _isLocked = !_isLocked),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded, size: 20, color: Colors.white70),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => ref.read(playerStateNotifierProvider.notifier).previousTrack(),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                        size: 24,
                        color: colorScheme.primary,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        if (isPlaying) {
                          ref.read(playbackNotifierProvider.notifier).pause();
                        } else {
                          ref.read(playbackNotifierProvider.notifier).resume();
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded, size: 20, color: Colors.white70),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => ref.read(playerStateNotifierProvider.notifier).nextTrack(),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18, color: Colors.white70),
                      tooltip: '关闭悬浮歌词',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => ref.read(floatingLyricsServiceProvider).setEnabled(false),
                    ),
                  ],
                ),
              ),

            // Main Lyric Display
            Text(
              lyricText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withAlpha(200),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),

            // Translation Line (If available)
            if (translation.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                translation,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withAlpha(210),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      color: Colors.black.withAlpha(180),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
