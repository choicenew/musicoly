import 'package:flutter/material.dart';
import 'package:lyric_protocol/lyric_protocol.dart';
import 'word_by_word_lyric_widget.dart';

/// Official Apple Music & Namida Style Smooth Auto-Scrolling Synced Lyrics List View
class OfficialSyncedLyricsListViewUI extends StatefulWidget {
  final List<LyricLineEntity> lines;
  final Duration currentPosition;
  final Function(Duration seekPosition)? onSeek;
  final double fontSize;
  final bool showTranslation;

  const OfficialSyncedLyricsListViewUI({
    super.key,
    required this.lines,
    required this.currentPosition,
    this.onSeek,
    this.fontSize = 24.0,
    this.showTranslation = true,
  });

  @override
  State<OfficialSyncedLyricsListViewUI> createState() => _OfficialSyncedLyricsListViewUIState();
}

class _OfficialSyncedLyricsListViewUIState extends State<OfficialSyncedLyricsListViewUI> {
  final ScrollController _scrollController = ScrollController();
  int _previousIndex = -1;

  int _findCurrentIndex() {
    if (widget.lines.isEmpty) return -1;
    for (int i = widget.lines.length - 1; i >= 0; i--) {
      if (widget.currentPosition >= widget.lines[i].startTime) {
        return i;
      }
    }
    return 0;
  }

  void _scrollToCurrentLine(int index) {
    if (!_scrollController.hasClients || index < 0) return;
    const itemHeight = 72.0;
    final targetOffset = index * itemHeight;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 450),
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
    if (widget.lines.isEmpty) {
      return const Center(
        child: Text(
          '暂无同步歌词数据',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    final currentIndex = _findCurrentIndex();

    if (currentIndex != _previousIndex) {
      _previousIndex = currentIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentLine(currentIndex);
      });
    }

    final theme = Theme.of(context);

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 240, horizontal: 28),
      itemCount: widget.lines.length,
      itemBuilder: (context, index) {
        final line = widget.lines[index];
        final isCurrent = index == currentIndex;

        return GestureDetector(
          onTap: () {
            widget.onSeek?.call(line.startTime);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                // 拼音 / 罗马音标注
                if (line.romanization != null && line.romanization!.isNotEmpty) ...[
                  Text(
                    line.romanization!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isCurrent ? widget.fontSize - 6 : widget.fontSize - 8,
                      color: isCurrent ? theme.colorScheme.primary.withValues(alpha: 0.8) : Colors.white30,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],

                // 逐字歌词/逐句歌词
                WordByWordLyricWidgetUI(
                  line: line,
                  currentPosition: widget.currentPosition,
                  isCurrentLine: isCurrent,
                  fontSize: widget.fontSize,
                  activeColor: theme.colorScheme.primary,
                  inactiveColor: Colors.white.withValues(alpha: 0.5),
                ),

                // 歌词翻译
                if (widget.showTranslation && line.translation != null && line.translation!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    line.translation!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isCurrent ? widget.fontSize - 3 : widget.fontSize - 6,
                      color: isCurrent ? theme.colorScheme.primary.withValues(alpha: 0.85) : Colors.white38,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
