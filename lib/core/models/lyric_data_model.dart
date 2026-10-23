import 'package:flutter/foundation.dart';

@immutable
class LyricLine {
  final Duration startTime;
  final String text;
  final String? translation;

  const LyricLine({
    required this.startTime,
    required this.text,
    this.translation,
  });
}

@immutable
class LyricData {
  final String trackId;
  final String trackName;
  final String artistNames;
  final String? plainLyrics;
  final List<LyricLine> syncedLines;
  final bool isSynced;

  const LyricData({
    required this.trackId,
    required this.trackName,
    required this.artistNames,
    this.plainLyrics,
    this.syncedLines = const [],
    this.isSynced = false,
  });
}
