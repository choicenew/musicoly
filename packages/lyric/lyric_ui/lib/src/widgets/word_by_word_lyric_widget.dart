import 'package:flutter/material.dart';
import 'package:lyric_protocol/lyric_protocol.dart';

/// Official Apple Music & Namida Style Syllable Word-By-Word Glowing Lyric Line Renderer
class WordByWordLyricWidgetUI extends StatelessWidget {
  final LyricLineEntity line;
  final Duration currentPosition;
  final bool isCurrentLine;
  final double fontSize;
  final Color activeColor;
  final Color inactiveColor;

  const WordByWordLyricWidgetUI({
    super.key,
    required this.line,
    required this.currentPosition,
    required this.isCurrentLine,
    this.fontSize = 24.0,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x99FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    if (line.words.isEmpty) {
      // 普通逐句歌词带平滑缩放与发光阴影
      return AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        style: TextStyle(
          fontSize: isCurrentLine ? fontSize + 4 : fontSize,
          fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.w500,
          color: isCurrentLine ? activeColor : inactiveColor,
          shadows: isCurrentLine
              ? [
                  Shadow(
                    color: activeColor.withValues(alpha: 0.7),
                    blurRadius: 16,
                  )
                ]
              : [],
        ),
        child: Text(
          line.text,
          textAlign: TextAlign.center,
        ),
      );
    }

    // 官方级 Apple Music 逐字音节填色与脉冲缩放动画
    return Wrap(
      alignment: WrapAlignment.center,
      cross: WrapCrossAlignment.center,
      children: line.words.map((syllable) {
        final isPassed = currentPosition >= (syllable.startTime + syllable.duration);
        final isPlaying = currentPosition >= syllable.startTime &&
            currentPosition < (syllable.startTime + syllable.duration);

        double fillProgress = 0.0;
        if (isPassed) {
          fillProgress = 1.0;
        } else if (isPlaying) {
          final elapsed = currentPosition - syllable.startTime;
          fillProgress = (elapsed.inMilliseconds / (syllable.duration.inMilliseconds.clamp(1, 10000)))
              .clamp(0.0, 1.0);
        }

        return AnimatedScale(
          scale: isPlaying ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [activeColor, inactiveColor],
                stops: [fillProgress, fillProgress],
              ).createShader(bounds);
            },
            child: Text(
              syllable.word,
              style: TextStyle(
                fontSize: isCurrentLine ? fontSize + 4 : fontSize,
                fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.w600,
                color: Colors.white,
                shadows: isPlaying
                    ? [
                        Shadow(
                          color: activeColor.withValues(alpha: 0.85),
                          blurRadius: 18,
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
