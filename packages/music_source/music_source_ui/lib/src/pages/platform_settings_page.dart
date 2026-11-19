import 'package:flutter/material.dart';
import 'package:music_source_hub/music_source_hub.dart';

class PlatformSettingsPage extends StatelessWidget {
  const PlatformSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hub = PlatformRegistryHub();
    final platforms = hub.availablePlatforms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('音源与平台管理 (Music Sources)'),
      ),
      body: ListView.builder(
        itemCount: platforms.length,
        itemBuilder: (context, index) {
          final platformId = platforms[index];
          final isSelected = platformId == hub.activePlatformId;
          return ListTile(
            title: Text(platformId.toUpperCase()),
            subtitle: Text(isSelected ? '当前活动音源 (Active Source)' : '离线/就绪 (Ready)'),
            trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
            onTap: () {
              hub.activePlatformId = platformId;
            },
          );
        },
      ),
    );
  }
}
