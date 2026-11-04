import 'package:pyro_music/core/models/lyric_data_model.dart';

/// LRC / Enhanced LRC / 逐字歌词解析工具
class LrcParser {
  /// 解析 LRC 或 Enhanced LRC (带有 <mm:ss.xx> 逐字时间戳) 歌词
  static List<LyricLine> parse(String lrcContent) {
    final rawLines = lrcContent.split('\n');
    final Map<Duration, _RawLine> lineMap = {};

    for (var line in rawLines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      // 解析时间戳 [mm:ss.xx] 或 [mm:ss.xxx]
      final lineRegex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\](.*)$');
      final match = lineRegex.firstMatch(trimmed);

      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final msStr = match.group(3)!;
        final milliseconds = int.parse(msStr) * (msStr.length == 2 ? 10 : 1);
        final content = match.group(4)!.trim();

        final startTime = Duration(
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
        );

        // 提取逐字时间戳，例如 <00:12.34>word
        final syllableRegex = RegExp(r'<(\d{2}):(\d{2})\.(\d{2,3})>([^<]*)');
        final syllableMatches = syllableRegex.allMatches(content);

        final words = <SyllableWord>[];
        String cleanText = '';

        if (syllableMatches.isNotEmpty) {
          for (var sm in syllableMatches) {
            final sMin = int.parse(sm.group(1)!);
            final sSec = int.parse(sm.group(2)!);
            final sMsStr = sm.group(3)!;
            final sMs = int.parse(sMsStr) * (sMsStr.length == 2 ? 10 : 1);
            final wordText = sm.group(4)!;

            final wordStart = Duration(minutes: sMin, seconds: sSec, milliseconds: sMs);
            words.add(SyllableWord(
              word: wordText,
              startTime: wordStart,
              duration: const Duration(milliseconds: 300), // 默认音节长度
            ));
            cleanText += wordText;
          }
        } else {
          cleanText = content;
        }

        if (lineMap.containsKey(startTime)) {
          // 若同一时间戳重复，可能是翻译行或拼音行
          final existing = lineMap[startTime]!;
          if (existing.translation == null) {
            lineMap[startTime] = existing.copyWith(translation: cleanText);
          } else if (existing.romanization == null) {
            lineMap[startTime] = existing.copyWith(romanization: cleanText);
          }
        } else {
          lineMap[startTime] = _RawLine(
            startTime: startTime,
            text: cleanText,
            words: words,
          );
        }
      }
    }

    final sortedKeys = lineMap.keys.toList()..sort();
    final lyricLines = <LyricLine>[];

    for (int i = 0; i < sortedKeys.length; i++) {
      final key = sortedKeys[i];
      final raw = lineMap[key]!;
      Duration? lineDuration;
      if (i < sortedKeys.length - 1) {
        lineDuration = sortedKeys[i + 1] - key;
      }

      lyricLines.add(LyricLine(
        startTime: raw.startTime,
        duration: lineDuration,
        text: raw.text,
        translation: raw.translation,
        romanization: raw.romanization,
        words: raw.words,
      ));
    }

    return lyricLines;
  }

  /// 导出为 LRC 格式
  static String export(List<LyricLine> lines, {Map<String, String>? metadata}) {
    final buffer = StringBuffer();

    if (metadata != null) {
      metadata.forEach((key, value) {
        buffer.writeln('[$key:$value]');
      });
    }

    for (var line in lines) {
      final minutes = (line.startTime.inMinutes).toString().padLeft(2, '0');
      final seconds = (line.startTime.inSeconds % 60).toString().padLeft(2, '0');
      final milliseconds = (line.startTime.inMilliseconds % 1000 ~/ 10)
          .toString()
          .padLeft(2, '0');

      buffer.writeln('[$minutes:$seconds.$milliseconds]${line.text}');
      if (line.translation != null && line.translation!.isNotEmpty) {
        buffer.writeln('[$minutes:$seconds.$milliseconds]${line.translation}');
      }
    }

    return buffer.toString();
  }
}

class _RawLine {
  final Duration startTime;
  final String text;
  final String? translation;
  final String? romanization;
  final List<SyllableWord> words;

  _RawLine({
    required this.startTime,
    required this.text,
    this.translation,
    this.romanization,
    this.words = const [],
  });

  _RawLine copyWith({
    String? translation,
    String? romanization,
  }) {
    return _RawLine(
      startTime: startTime,
      text: text,
      translation: translation ?? this.translation,
      romanization: romanization ?? this.romanization,
      words: words,
    );
  }
}

