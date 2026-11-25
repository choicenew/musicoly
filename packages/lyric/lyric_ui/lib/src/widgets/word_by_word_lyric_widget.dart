import 'package:flutter/material.dart';
import 'package:lyric_protocol/lyric_protocol.dart';

class WordByWordLyricWidgetUI extends StatelessWidget {
  final LyricLineEntity line;
  final Duration currentPosition;

  const WordByWordLyricWidgetUI({
    super.key,
    required this.line,
    required this.currentPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      line.text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
