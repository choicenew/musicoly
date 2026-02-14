import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';

class SyncedLyricsWidget extends StatelessWidget {
  final LyricData lyrics;

  const SyncedLyricsWidget({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lyrics.lines.length,
      itemBuilder: (context, index) {
        final lyricLine = lyrics.lines[index];
        return ListTile(
          title: Text(lyricLine.text),
          subtitle: lyricLine.translation != null ? Text(lyricLine.translation!) : null,
        );
      },
    );
  }
}