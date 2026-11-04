import 'package:flutter/foundation.dart';

/// 逐字/逐音节时间戳
@immutable
class SyllableWord {
  final String word;
  final Duration startTime;
  final Duration duration;

  const SyllableWord({
    required this.word,
    required this.startTime,
    required this.duration,
  });

  Duration get endTime => startTime + duration;
}

@immutable
class LyricLine {
  final Duration startTime;
  final Duration? duration;
  final String text;
  final String? translation;
  final String? romanization; // 罗马音/拼音
  final List<SyllableWord> words; // 逐字/逐音节数据

  const LyricLine({
    required this.startTime,
    this.duration,
    required this.text,
    this.translation,
    this.romanization,
    this.words = const [],
  });

  bool get hasSyllables => words.isNotEmpty;

  Duration get endTime {
    if (duration != null) return startTime + duration!;
    if (words.isNotEmpty) return words.last.endTime;
    return startTime + const Duration(seconds: 4);
  }
}

@immutable
class LyricData {
  final String trackId;
  final String trackName;
  final String artistNames;
  final String? plainLyrics;
  final List<LyricLine> syncedLines;
  final bool isSynced;
  final Map<String, dynamic> metadata;

  List<LyricLine> get lines => syncedLines;

  const LyricData({
    required this.trackId,
    required this.trackName,
    required this.artistNames,
    this.plainLyrics,
    this.syncedLines = const [],
    this.isSynced = false,
    this.metadata = const {},
  });
}

