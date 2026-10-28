import 'package:flutter/material.dart';

/// A widget that displays a volume slider with a mute button
class VolumeSlider extends StatelessWidget {
  /// Current volume level (0.0 to 1.0)
  final double volume;

  /// Whether the audio is currently muted
  final bool isMuted;

  /// Callback when the volume level changes
  final Function(double)? onVolumeChanged;

  /// Callback when the mute button is pressed
  final VoidCallback? onMuteToggle;

  const VolumeSlider({
    super.key,
    required this.volume,
    this.isMuted = false,
    this.onVolumeChanged,
    this.onMuteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Mute button
        IconButton(
          icon: Icon(_getVolumeIcon()),
          onPressed: onMuteToggle,
          tooltip: isMuted ? 'Unmute' : 'Mute',
        ),

        // Volume slider
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              activeTrackColor: theme.colorScheme.primary,
              inactiveTrackColor: theme.colorScheme.primary.withValues(alpha: 0.3),
              thumbColor: theme.colorScheme.primary,
              overlayColor: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: isMuted ? 0.0 : volume,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                if (onVolumeChanged != null) {
                  onVolumeChanged!(value);
                }
              },
            ),
          ),
        ),

        // Volume percentage
        SizedBox(
          width: 40,
          child: Text(
            '${(isMuted ? 0 : (volume * 100).round())}%',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  IconData _getVolumeIcon() {
    if (isMuted || volume <= 0.0) {
      return Icons.volume_off;
    } else if (volume < 0.5) {
      return Icons.volume_down;
    } else {
      return Icons.volume_up;
    }
  }
}
