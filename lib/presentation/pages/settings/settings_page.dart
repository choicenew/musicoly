import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/settings_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SettingsSection(),
        ],
      ),
    );
  }
}
