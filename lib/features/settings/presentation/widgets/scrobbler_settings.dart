import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';
import 'package:pyro_music/core/services/scrobbler_manager.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class ScrobblerSettings extends ConsumerWidget {
  const ScrobblerSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final manager = ref.watch(scrobblerManagerProvider);
    final prefs = ref.watch(userPreferencesProvider).value;
    final scrobblers = manager.getScrobblers();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                l10n.scrobbler,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              l10n.scrobbler_description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: 8),
            if (scrobblers.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(l10n.no_results_found('Scrobblers')),
                ),
              )
            else
              ...scrobblers.map((scrobbler) {
                final isEnabled = prefs?.scrobblerEnabledStates[scrobbler.serviceId] ?? scrobbler.isEnabled;
                
                return Column(
                  children: [
                    SwitchListTile(
                      title: Text(scrobbler.serviceName),
                      subtitle: Text(
                        scrobbler.isAuthenticated
                            ? l10n.connected
                            : l10n.not_connected,
                      ),
                      value: isEnabled,
                      onChanged: (value) async {
                        await ref.read(userPreferencesProvider.notifier).setScrobblerEnabled(scrobbler.serviceId, value);
                        await scrobbler.setEnabled(value);
                      },
                    ),
                    if (isEnabled)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Row(
                          children: [
                            if (!scrobbler.isAuthenticated)
                              ElevatedButton(
                                onPressed: () => scrobbler.authenticate(),
                                child: Text(l10n.login),
                              )
                            else
                              TextButton(
                                onPressed: () async {
                                  await scrobbler.logout();
                                  ref.invalidate(scrobblerManagerProvider);
                                },
                                child: Text(
                                  l10n.logout,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    const Divider(),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}
