import 'package:flutter/material.dart';
import 'package:audio_player_hub/audio_player_hub.dart';
import 'package:audio_player_protocol/audio_player_protocol.dart';

class MiniPlayerWidget extends StatefulWidget {
  final VoidCallback? onTap;

  const MiniPlayerWidget({super.key, this.onTap});

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  final _hub = AudioPlayerHub();

  @override
  Widget build(BuildContext context) {
    final state = _hub.currentState;
    final isPlaying = state.status == PlaybackStatus.playing;

    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: widget.onTap,
        leading: const Icon(Icons.music_note, size: 32),
        title: const Text('Pyro Audio Player'),
        subtitle: Text(isPlaying ? '播放中 (Playing)' : '已暂停 (Paused)'),
        trailing: IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (isPlaying) {
              _hub.pause();
            } else {
              _hub.resume();
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
