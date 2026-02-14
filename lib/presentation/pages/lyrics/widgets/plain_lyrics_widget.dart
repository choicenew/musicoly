import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';

class PlainLyricsWidget extends StatelessWidget {
  final LyricData lyrics;

  const PlainLyricsWidget({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: Column(
          children: lyrics.lines.map((line) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    line.text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (line.translation != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      line.translation!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}