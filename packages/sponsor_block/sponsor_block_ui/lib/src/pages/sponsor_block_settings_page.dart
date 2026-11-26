import 'package:flutter/material.dart';

class SponsorBlockSettingsPage extends StatelessWidget {
  const SponsorBlockSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SponsorBlock Settings')),
      body: const Center(
        child: Text('Configure automatic sponsor skipping for music videos.'),
      ),
    );
  }
}
