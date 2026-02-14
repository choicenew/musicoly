import 'package:flutter/material.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class DesktopSettings extends StatelessWidget {
  const DesktopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text(l10n.auto_start),
              subtitle: Text(l10n.auto_start_description),
              value: false,
              onChanged: (value) {
                // TODO: 实现开机自启动设置
              },
            ),
            SwitchListTile(
              title: Text(l10n.minimize_to_tray),
              subtitle: Text(l10n.minimize_to_tray_description),
              value: true,
              onChanged: (value) {
                // TODO: 实现最小化到系统托盘设置
              },
            ),
            SwitchListTile(
              title: Text(l10n.media_key_control),
              subtitle: Text(l10n.media_key_control_description),
              value: true,
              onChanged: (value) {
                // TODO: 实现媒体键控制设置
              },
            ),
            SwitchListTile(
              title: Text(l10n.system_notifications),
              subtitle: Text(l10n.system_notifications_description),
              value: true,
              onChanged: (value) {
                // TODO: 实现系统通知设置
              },
            ),
            ListTile(
              title: Text(l10n.shortcut_settings),
              subtitle: Text(l10n.shortcut_settings_description),
              trailing: TextButton(
                onPressed: () {
                  // TODO: 实现快捷键设置
                },
                child: Text(l10n.set),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
