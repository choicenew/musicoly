import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// YesPlayMusic & Musify Style High-Performance Smooth Auto-Scrolling Synced Lyrics Widget
class SyncedLyricsWidget extends ConsumerStatefulWidget {
  final LyricData lyrics;

  const SyncedLyricsWidget({
    super.key,
    required this.lyrics,
  });

  @override
  ConsumerState<SyncedLyricsWidget> createState() => _SyncedLyricsWidgetState();
}

class _SyncedLyricsWidgetState extends ConsumerState<SyncedLyricsWidget> {
  final ScrollController _scrollController = ScrollController();
  int _previousIndex = -1;

  void _scrollToIndex(int index, double lineSpacing) {
    if (!_scrollController.hasClients || index < 0) return;
    
    // Approximate item height based on spacing
    final itemHeight = 60.0 * lineSpacing;
    final targetOffset = index * itemHeight;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lyricController = ref.watch(LyricController.provider);
    final theme = Theme.of(context);

    if (widget.lyrics.syncedLines.isEmpty) {
      return const Center(
        child: Text(
          '无同步歌词数据',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    final currentIndex = lyricController.currentLyricIndex.value;
    final autoScroll = lyricController.autoScroll.value;
    final lineSpacing = lyricController.lineSpacing.value;

    if (autoScroll && currentIndex != _previousIndex) {
      _previousIndex = currentIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToIndex(currentIndex, lineSpacing);
      });
    }

    return ValueListenableBuilder<double>(
      valueListenable: lyricController.fontSize,
      builder: (context, fontSize, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: lyricController.showTranslation,
          builder: (context, showTranslation, _) {
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 220, horizontal: 28),
              itemCount: widget.lyrics.syncedLines.length,
              itemBuilder: (context, index) {
                final lyricLine = widget.lyrics.syncedLines[index];
                final isCurrentLine = index == currentIndex;

                return GestureDetector(
                  onTap: () {
                    ref.read(playbackStateProvider.notifier).seekTo(lyricLine.startTime);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.symmetric(vertical: 10.0 * lineSpacing),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            fontSize: isCurrentLine ? fontSize + 6 : fontSize,
                            fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.w500,
                            color: isCurrentLine
                                ? theme.colorScheme.primary
                                : Colors.white.withValues(alpha: 0.6),
                            shadows: isCurrentLine
                                ? [
                                    Shadow(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.6),
                                      blurRadius: 16,
                                    )
                                  ]
                                : [],
                          ),
                          child: Text(
                            lyricLine.text,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (showTranslation && lyricLine.translation != null && lyricLine.translation!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            style: TextStyle(
                              fontSize: isCurrentLine ? fontSize : fontSize - 3,
                              color: isCurrentLine
                                  ? theme.colorScheme.primary.withValues(alpha: 0.85)
                                  : Colors.white38,
                            ),
                            child: Text(
                              lyricLine.translation!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
