import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';

/// 纯文本歌词展示组件
class PlainLyricsWidget extends ConsumerWidget {
  final LyricData lyrics;

  const PlainLyricsWidget({
    super.key,
    required this.lyrics,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lyricController = ref.watch(LyricController.provider);
    final theme = Theme.of(context);

    if (lyrics.plainLyrics == null || lyrics.plainLyrics!.isEmpty) {
      return const Center(
        child: Text('无纯文本歌词'),
      );
    }

    return ValueListenableBuilder<double>(
      valueListenable: lyricController.fontSize,
      builder: (context, fontSize, _) {
        return ValueListenableBuilder<double>(
          valueListenable: lyricController.lineSpacing,
          builder: (context, lineSpacing, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: SelectableText(
                lyrics.plainLyrics!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: fontSize,
                  height: lineSpacing,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
