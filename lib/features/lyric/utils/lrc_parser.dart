import 'package:pyro_music/core/models/lyric_data_model.dart';

/// LRC 歌词解析与导出工具
class LrcParser {
  /// 解析 LRC 格式歌词
  static List<LyricLine> parse(String lrcContent) {
    final lines = lrcContent.split('\n');
    final lyricLines = <LyricLine>[];

    for (var line in lines) {
      // 解析 LRC 时间戳 [mm:ss.xx] 或 [mm:ss.xxx]
      final regex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\](.*)$');
      final match = regex.firstMatch(line);

      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final msStr = match.group(3)!;
        final milliseconds = int.parse(msStr) * (msStr.length == 2 ? 10 : 1);
        final text = match.group(4)!.trim();

        final startTime = Duration(
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
        );
        lyricLines.add(LyricLine(startTime: startTime, text: text));
      }
    }
    return lyricLines;
  }

  /// 导出为 LRC 格式
  static String export(List<LyricLine> lines, {Map<String, String>? metadata}) {
    final buffer = StringBuffer();

    // 添加元数据
    if (metadata != null) {
      metadata.forEach((key, value) {
        buffer.writeln('[$key:$value]');
      });
    }

    // 添加时间戳歌词
    for (var line in lines) {
      final minutes = (line.startTime.inMinutes).toString().padLeft(2, '0');
      final seconds = (line.startTime.inSeconds % 60).toString().padLeft(2, '0');
      final milliseconds = (line.startTime.inMilliseconds % 1000 ~/ 10)
          .toString()
          .padLeft(2, '0');

      buffer.writeln('[$minutes:$seconds.$milliseconds]${line.text}');
    }

    return buffer.toString();
  }
}
