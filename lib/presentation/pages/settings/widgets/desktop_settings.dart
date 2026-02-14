import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class DesktopSettings extends ConsumerWidget {
  const DesktopSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final preferences = ref.watch(userPreferencesProvider);

    return preferences.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (prefs) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: Text(l10n.auto_start),
                subtitle: Text(l10n.auto_start_description),
                value: prefs.autoStart,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setAutoStart(value);
                },
              ),
              SwitchListTile(
                title: Text(l10n.minimize_to_tray),
                subtitle: Text(l10n.minimize_to_tray_description),
                value: prefs.minimizeToTray,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setMinimizeToTray(value);
                },
              ),
              SwitchListTile(
                title: Text(l10n.media_key_control),
                subtitle: Text(l10n.media_key_control_description),
                value: prefs.mediaKeyControl,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setMediaKeyControl(value);
                },
              ),
              SwitchListTile(
                title: Text(l10n.system_notifications),
                subtitle: Text(l10n.system_notifications_description),
                value: prefs.systemNotifications,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setSystemNotifications(value);
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
      ),
    );
  }
}
