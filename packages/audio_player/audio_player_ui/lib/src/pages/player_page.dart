import 'package:flutter/material.dart';
import 'package:audio_player_hub/audio_player_hub.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hub = AudioPlayerHub();

    return Scaffold(
      appBar: AppBar(
        title: const Text('播放器 (Player)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.album, size: 128),
            ),
            const SizedBox(height: 32),
            const Text(
              'Pyro Core Audio Engine',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () => hub.resume(),
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.pause),
                  onPressed: () => hub.pause(),
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.stop),
                  onPressed: () => hub.stop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
