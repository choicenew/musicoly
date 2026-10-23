import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';

class SyncedLyricsWidget extends StatelessWidget {
  final LyricsInterface lyrics;

  const SyncedLyricsWidget({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lyrics.syncedLyrics.length,
      itemBuilder: (context, index) {
        final lyricLine = lyrics.syncedLyrics[index][1] as String;
        return ListTile(
          title: Text(lyricLine),
        );
      },
    );
  }
}