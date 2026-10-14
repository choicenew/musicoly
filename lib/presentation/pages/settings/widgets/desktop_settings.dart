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
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.shortcut_settings),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ShortcutItem(label: '${l10n.play}/${l10n.pause}', keys: 'Space'),
                            _ShortcutItem(label: l10n.next, keys: 'Ctrl + Right'),
                            _ShortcutItem(label: l10n.previous, keys: 'Ctrl + Left'),
                            const _ShortcutItem(label: 'Seek Forward 10s', keys: 'Right'),
                            const _ShortcutItem(label: 'Seek Backward 10s', keys: 'Left'),
                            const _ShortcutItem(label: 'Volume Up/Down', keys: 'Up / Down'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(l10n.ok),
                          ),
                        ],
                      ),
                    );
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

class _ShortcutItem extends StatelessWidget {
  final String label;
  final String keys;

  const _ShortcutItem({required this.label, required this.keys});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              keys,
              style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
