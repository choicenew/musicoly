import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';

class PlainLyricsWidget extends StatelessWidget {
  final LyricData lyrics;

  const PlainLyricsWidget({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    final text = lyrics.lines.map((e) => e.text).join('\n');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text),
      ),
    );
  }
}