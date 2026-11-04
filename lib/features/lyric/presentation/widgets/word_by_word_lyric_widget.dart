import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';

/// Apple Music & Namida Style Syllable Word-By-Word Lyrics Line Renderer
class WordByWordLyricWidget extends StatelessWidget {
  final LyricLine line;
  final Duration currentPosition;
  final bool isCurrentLine;
  final double fontSize;
  final Color activeColor;
  final Color inactiveColor;

  const WordByWordLyricWidget({
    super.key,
    required this.line,
    required this.currentPosition,
    required this.isCurrentLine,
    this.fontSize = 22.0,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!line.hasSyllables) {
      // 普通整句歌词
      return Text(
        line.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isCurrentLine ? fontSize + 4 : fontSize,
          fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.w500,
          color: isCurrentLine ? activeColor : inactiveColor,
        ),
      );
    }

    // 逐字/逐音节歌词流式填色与缩放动效
    return Wrap(
      alignment: WrapAlignment.center,
      cross: WrapCrossAlignment.center,
      children: line.words.map((syllable) {
        final isPassed = currentPosition >= syllable.endTime;
        final isPlaying = currentPosition >= syllable.startTime && currentPosition < syllable.endTime;

        double progress = 0.0;
        if (isPassed) {
          progress = 1.0;
        } else if (isPlaying) {
          final elapsed = currentPosition - syllable.startTime;
          progress = (elapsed.inMilliseconds / (syllable.duration.inMilliseconds.clamp(1, 10000))).clamp(0.0, 1.0);
        }

        return AnimatedScale(
          scale: isPlaying ? 1.12 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [activeColor, inactiveColor],
                stops: [progress, progress],
              ).createShader(bounds);
            },
            child: Text(
              syllable.word,
              style: TextStyle(
                fontSize: isCurrentLine ? fontSize + 4 : fontSize,
                fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.w500,
                color: Colors.white, // 基础颜色供 ShaderMask 线性渐变遮罩使用
                shadows: isPlaying
                    ? [
                        Shadow(
                          color: activeColor.withValues(alpha: 0.8),
                          blurRadius: 14,
                        )
                      ]
                    : [],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
