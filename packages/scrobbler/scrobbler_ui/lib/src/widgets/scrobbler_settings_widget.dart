import 'package:flutter/material.dart';

class ScrobblerSettingsWidget extends StatelessWidget {
  const ScrobblerSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Last.fm 同步 (Last.fm Scrobbler)'),
          subtitle: const Text('已连接 (Connected)'),
          value: true,
          onChanged: (val) {},
        ),
        SwitchListTile(
          title: const Text('ListenBrainz 同步'),
          subtitle: const Text('未绑定 (Not Configured)'),
          value: false,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
