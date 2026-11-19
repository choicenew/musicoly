import 'package:flutter/material.dart';
import 'package:music_source_hub/music_source_hub.dart';

class SourceSelectorWidget extends StatelessWidget {
  const SourceSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hub = PlatformRegistryHub();
    final platforms = hub.availablePlatforms;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.tune),
      onSelected: (platformId) {
        hub.activePlatformId = platformId;
      },
      itemBuilder: (context) {
        return platforms.map((p) {
          return PopupMenuItem<String>(
            value: p,
            child: Text(p.toUpperCase()),
          );
        }).toList();
      },
    );
  }
}
