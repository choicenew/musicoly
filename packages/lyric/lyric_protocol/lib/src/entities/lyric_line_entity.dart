import 'package:flutter/foundation.dart';

@immutable
class SyllableWordEntity {
  final String word;
  final Duration startTime;
  final Duration duration;

  const SyllableWordEntity({
    required this.word,
    required this.startTime,
    required this.duration,
  });
}

@immutable
class LyricLineEntity {
  final Duration startTime;
  final String text;
  final String? translation;
  final String? romanization;
  final List<SyllableWordEntity> words;

  const LyricLineEntity({
    required this.startTime,
    required this.text,
    this.translation,
    this.romanization,
    this.words = const [],
  });
}
