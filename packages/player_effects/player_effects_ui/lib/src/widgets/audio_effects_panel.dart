import 'package:flutter/material.dart';

/// Official Production Audio Effects Panel UI (10-Band EQ, Bass Boost, Speed, Pitch & Reverb)
class AudioEffectsPanelUI extends StatefulWidget {
  const AudioEffectsPanelUI({super.key});

  @override
  State<AudioEffectsPanelUI> createState() => _AudioEffectsPanelUIState();
}

class _AudioEffectsPanelUIState extends State<AudioEffectsPanelUI> {
  bool _isEnabled = true;
  double _bassBoost = 0.4;
  double _playbackSpeed = 1.0;
  double _pitchShift = 1.0;
  String _selectedPreset = 'Pop';
  final List<double> _bandLevels = [0, 2, 4, 3, 0, -1, -2, -1, 1, 3];
  final List<int> _frequencies = [31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
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
                  Icon(Icons.tune, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    '音频音效控制中枢 (Audio Effects)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _isEnabled,
                onChanged: (val) => setState(() => _isEnabled = val),
              ),
            ],
          ),
          const Divider(height: 24),

          if (_isEnabled) ...[
            // 均衡器 10 段手势调节
            Text(
              '10 段均衡器 (10-Band EQ)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _bandLevels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      children: [
                        Text(
                          '${_bandLevels[index].toInt()}dB',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: _bandLevels[index],
                              min: -12.0,
                              max: 12.0,
                              onChanged: (val) {
                                setState(() => _bandLevels[index] = val);
                              },
                            ),
                          ),
                        ),
                        Text(
                          _frequencies[index] >= 1000
                              ? '${(_frequencies[index] / 1000).toStringAsFixed(0)}k'
                              : '${_frequencies[index]}',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 重低音增强
            Text(
              '低音增强 (Bass Boost): ${(_bassBoost * 100).toInt()}%',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _bassBoost,
              min: 0.0,
              max: 1.0,
              onChanged: (val) => setState(() => _bassBoost = val),
            ),
            const SizedBox(height: 12),

            // 变速与变调
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('播放速度: ${_playbackSpeed.toStringAsFixed(1)}x', style: theme.textTheme.bodySmall),
                      Slider(
                        value: _playbackSpeed,
                        min: 0.5,
                        max: 2.0,
                        onChanged: (val) => setState(() => _playbackSpeed = val),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('声调 Pitch: ${_pitchShift.toStringAsFixed(1)}x', style: theme.textTheme.bodySmall),
                      Slider(
                        value: _pitchShift,
                        min: 0.5,
                        max: 2.0,
                        onChanged: (val) => setState(() => _pitchShift = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
