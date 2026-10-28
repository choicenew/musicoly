import 'package:flutter/material.dart';

/// A widget that displays playback controls (play/pause, next, previous, etc.)
class PlayerControls extends StatelessWidget {
  /// Whether a track is currently playing
  final bool isPlaying;

  /// Whether shuffle mode is enabled
  final bool isShuffleEnabled;

  /// The current repeat mode
  final RepeatMode repeatMode;

  /// Callback when the play/pause button is pressed
  final VoidCallback? onPlayPause;

  /// Callback when the next button is pressed
  final VoidCallback? onNext;

  /// Callback when the previous button is pressed
  final VoidCallback? onPrevious;

  /// Callback when the shuffle button is pressed
  final VoidCallback? onShuffle;

  /// Callback when the repeat button is pressed
  final VoidCallback? onRepeat;

  const PlayerControls({
    Key? key,
    this.isPlaying = false,
    this.isShuffleEnabled = false,
    this.repeatMode = RepeatMode.off,
    this.onPlayPause,
    this.onNext,
    this.onPrevious,
    this.onShuffle,
    this.onRepeat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final iconColor = theme.iconTheme.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Shuffle button
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: isShuffleEnabled ? primaryColor : iconColor,
          ),
          onPressed: onShuffle,
          tooltip: 'Shuffle',
        ),

        // Previous track button
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 40,
          onPressed: onPrevious,
          tooltip: 'Previous',
        ),

        // Play/Pause button
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            iconSize: 32,
            onPressed: onPlayPause,
            tooltip: isPlaying ? 'Pause' : 'Play',
          ),
        ),

        // Next track button
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 40,
          onPressed: onNext,
          tooltip: 'Next',
        ),

        // Repeat button
        IconButton(
          icon: Icon(
            _getRepeatIcon(),
            color: repeatMode != RepeatMode.off ? primaryColor : iconColor,
          ),
          onPressed: onRepeat,
          tooltip: 'Repeat',
        ),
      ],
    );
  }

  IconData _getRepeatIcon() {
    switch (repeatMode) {
      case RepeatMode.off:
        return Icons.repeat;
      case RepeatMode.all:
        return Icons.repeat;
      case RepeatMode.one:
        return Icons.repeat_one;
    }
  }
}

/// Enum representing the different repeat modes
enum RepeatMode {
  /// No repeat
  off,

  /// Repeat all tracks in the queue
  all,

  /// Repeat the current track
  one,
}
