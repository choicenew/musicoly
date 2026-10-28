import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/equalizer_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class EqualizerSettings extends ConsumerWidget {
  const EqualizerSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(equalizerProvider);
    final notifier = ref.read(equalizerProvider.notifier);

    final frequencies = [31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.equalizer,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Switch(
                value: state.isEnabled,
                onChanged: (value) => notifier.setEnabled(value),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.enable_equalizer,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          if (state.isEnabled) ...[
            const SizedBox(height: 24),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.bandLevels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        Text(
                          '${state.bandLevels[index].toInt()}dB',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                                activeTrackColor: theme.colorScheme.primary,
                                inactiveTrackColor: theme.colorScheme.surfaceContainerHighest,
                              ),
                              child: Slider(
                                value: state.bandLevels[index],
                                min: -10.0,
                                max: 10.0,
                                onChanged: (value) => notifier.setBandLevel(index, value),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          frequencies[index] >= 1000 
                            ? '${(frequencies[index] / 1000).toStringAsFixed(0)}k' 
                            : '${frequencies[index]}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  for (int i = 0; i < state.bandLevels.length; i++) {
                    notifier.setBandLevel(i, 0.0);
                  }
                },
                child: const Text('Reset'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
