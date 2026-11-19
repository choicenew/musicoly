import 'package:flutter/material.dart';

class EqualizerDialog extends StatefulWidget {
  const EqualizerDialog({super.key});

  @override
  State<EqualizerDialog> createState() => _EqualizerDialogState();
}

class _EqualizerDialogState extends State<EqualizerDialog> {
  final List<double> _gains = List.filled(10, 0.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('10阶音频均衡器 (Equalizer)'),
      content: SizedBox(
        width: 320,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) {
            return Column(
              children: [
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _gains[index],
                      min: -12.0,
                      max: 12.0,
                      onChanged: (val) {
                        setState(() {
                          _gains[index] = val;
                        });
                      },
                    ),
                  ),
                ),
                Text('${index + 1}'),
              ],
            );
          }),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('完成 (Done)'),
        ),
      ],
    );
  }
}
