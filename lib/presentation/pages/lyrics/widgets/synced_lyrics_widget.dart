import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

class SyncedLyricsWidget extends ConsumerStatefulWidget {
  final LyricData lyrics;

  const SyncedLyricsWidget({super.key, required this.lyrics});

  @override
  ConsumerState<SyncedLyricsWidget> createState() => _SyncedLyricsWidgetState();
}

class _SyncedLyricsWidgetState extends ConsumerState<SyncedLyricsWidget> {
  late final ScrollController _scrollController;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (_isUserScrolling || !_scrollController.hasClients) return;

    const double itemHeight = 70.0; // Estimated height for lyric lines
    final double viewportHeight = _scrollController.position.viewportDimension;
    final double targetOffset = (index * itemHeight) - (viewportHeight / 2) + (itemHeight / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIdx = ref.watch(LyricController.provider).currentLyricIndex.value;
    
    // Auto scroll when index changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentIdx >= 0) {
        _scrollToIndex(currentIdx);
      }
    });

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            _isUserScrolling = true;
          }
        } else if (notification is ScrollEndNotification) {
          _isUserScrolling = false;
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 100),
        itemCount: widget.lyrics.lines.length,
        itemBuilder: (context, index) {
          final lyricLine = widget.lyrics.lines[index];
          final isCurrent = index == currentIdx;

          return GestureDetector(
            onTap: () {
              // Seek to this lyric time
              ref.read(playbackStateProvider.notifier).seekTo(lyricLine.startTime);
            },
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isCurrent ? 1.0 : 0.4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: isCurrent ? 22 : 18,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      child: Text(lyricLine.text),
                    ),
                    if (lyricLine.translation != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        lyricLine.translation!,
                        style: TextStyle(
                          fontSize: isCurrent ? 16 : 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}