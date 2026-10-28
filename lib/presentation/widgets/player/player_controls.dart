import 'package:flutter/material.dart' hide RepeatMode;
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/generated/app_localizations.dart';

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
    super.key,
    this.isPlaying = false,
    this.isShuffleEnabled = false,
    this.repeatMode = RepeatMode.off,
    this.onPlayPause,
    this.onNext,
    this.onPrevious,
    this.onShuffle,
    this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
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
          tooltip: l10n.shuffle,
        ),

        // Previous button
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: onPrevious,
          tooltip: l10n.previous,
        ),

        // Play/Pause button
        FloatingActionButton(
          onPressed: onPlayPause,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),

        // Next button
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: onNext,
          tooltip: l10n.next,
        ),

        // Repeat button
        IconButton(
          icon: Icon(
            _getRepeatIcon(),
            color: repeatMode != RepeatMode.off ? primaryColor : iconColor,
          ),
          onPressed: onRepeat,
          tooltip: l10n.repeat,
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
