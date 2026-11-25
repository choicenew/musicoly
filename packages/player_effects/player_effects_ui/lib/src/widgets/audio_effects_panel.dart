import 'package:flutter/material.dart';

class AudioEffectsPanelUI extends StatelessWidget {
  const AudioEffectsPanelUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('音效中枢与 10 段均衡器预设'),
      ),
    );
  }
}
