import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';

class PlainLyricsWidget extends StatelessWidget {
  final LyricsInterface lyrics;

  const PlainLyricsWidget({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(lyrics.text),
      ),
    );
  }
}