import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/services/equalizer_service.dart';
import 'package:pyro_music/features/player/providers/equalizer_provider.dart';

/// 完整音效调控面板组件 (Equalizer, Bass Boost, Speed, Pitch & Reverb)
class AudioEffectsDialog extends ConsumerWidget {
  const AudioEffectsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eqState = ref.watch(equalizerNotifierProvider);
    final eqNotifier = ref.read(equalizerNotifierProvider.notifier);
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.graphic_eq, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      '音效控制中枢',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: eqState.isEnabled,
                  onChanged: (val) => eqNotifier.setEnabled(val),
                ),
              ],
            ),
            const Divider(height: 24),

            if (eqState.isEnabled) ...[
              // 预设选择器
              Text(
                '均衡器预设 (Preset)',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: EqualizerPreset.values.map((preset) {
                  final isSelected = eqState.currentPreset == preset;
                  return ChoiceChip(
                    label: Text(preset.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) eqNotifier.applyPreset(preset);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // 重低音增强 (Bass Boost)
              Text(
                '低音增强 (Bass Boost): ${(eqState.bassBoost * 100).toInt()}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: eqState.bassBoost,
                min: 0.0,
                max: 1.0,
                onChanged: (val) => eqNotifier.setBassBoost(val),
              ),
              const SizedBox(height: 12),

              // 混响预设 (Reverb)
              Text(
                '空间混响 (Reverb)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              SegmentedButton<ReverbPreset>(
                segments: ReverbPreset.values.map((r) {
                  return ButtonSegment(value: r, label: Text(r.label));
                }).toList(),
                selected: {eqState.reverbPreset},
                onSelectionChanged: (selected) {
                  eqNotifier.setReverbPreset(selected.first);
                },
              ),
              const SizedBox(height: 20),

              // 播放速度与 Pitch 声调
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '播放速度: ${eqState.playbackSpeed.toStringAsFixed(1)}x',
                          style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: eqState.playbackSpeed,
                          min: 0.5,
                          max: 2.0,
                          divisions: 15,
                          onChanged: (val) => eqNotifier.setPlaybackSpeed(val),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '声调 Pitch: ${eqState.pitchShift.toStringAsFixed(1)}x',
                          style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: eqState.pitchShift,
                          min: 0.5,
                          max: 2.0,
                          divisions: 15,
                          onChanged: (val) => eqNotifier.setPitchShift(val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('完成'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
