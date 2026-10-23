import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// 时间同步歌词展示组件
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
        child: Text('无同步歌词数据'),
      );
    }

    return ValueListenableBuilder<double>(
      valueListenable: lyricController.fontSize,
      builder: (context, fontSize, _) {
        return ValueListenableBuilder<double>(
          valueListenable: lyricController.lineSpacing,
          builder: (context, lineSpacing, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: lyricController.showTranslation,
              builder: (context, showTranslation, _) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 24),
                  itemCount: widget.lyrics.syncedLines.length,
                  itemBuilder: (context, index) {
                    final lyricLine = widget.lyrics.syncedLines[index];
                    final isCurrentLine = index == lyricController.currentLyricIndex.value;

                    return GestureDetector(
                      onTap: () {
                        ref.read(playbackStateProvider.notifier).seekTo(lyricLine.startTime);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0 * lineSpacing),
                        child: Column(
                          children: [
                            Text(
                              lyricLine.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isCurrentLine ? fontSize + 4 : fontSize,
                                fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.normal,
                                color: isCurrentLine ? theme.colorScheme.primary : Colors.white70,
                              ),
                            ),
                            if (showTranslation && lyricLine.translation != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                lyricLine.translation!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontSize - 2,
                                  color: isCurrentLine ? theme.colorScheme.primary.withValues(alpha: 0.8) : Colors.white54,
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
      },
    );
  }
}
