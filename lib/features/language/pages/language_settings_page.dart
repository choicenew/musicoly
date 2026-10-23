import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';
import 'package:pyro_music/features/language/provider/language_provider.dart';
import 'package:pyro_music/features/language/language_data.dart';
import 'package:pyro_music/features/language/widgets/language_selection_widget.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class LanguageSettingsPage extends ConsumerStatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  ConsumerState<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends ConsumerState<LanguageSettingsPage> {
  final List<Map<String, dynamic>> _supportedLocales = languages;
  List<String> _timeZones = [];
  String _initialTimeZone = 'UTC';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final zones = await FlutterTimezone.getAvailableTimezones();
      if (mounted) {
        setState(() {
          _timeZones = zones;
          _initialTimeZone = zones.firstWhere(
            (zone) => zone == 'Asia/Shanghai',
            orElse: () => 'UTC'
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncLocale = ref.watch(localeProvider);
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language_settings),
      ),
      body: asyncLocale.when(
        data: (currentLocale) => preferencesAsync.when(
          data: (preferences) => ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              LanguageSelectionWidget(
                supportedLocales: _supportedLocales,
                currentLocale: currentLocale,
                localeNotifier: ref.read(localeProvider.notifier),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                l10n.language_region,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              if (_timeZones.isNotEmpty)
                ListTile(
                  title: Text(l10n.timeZone),
                  trailing: DropdownButton<String>(
                    value: preferences.timeZone ?? _initialTimeZone,
                    items: _timeZones.map((zone) {
                      return DropdownMenuItem(
                        value: zone,
                        child: Text(zone),
                      );
                    }).toList(),
                    onChanged: (zone) {
                      if (zone != null) {
                        ref.read(userPreferencesProvider.notifier).setTimeZone(zone);
                      }
                    },
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),
              SwitchListTile(
                title: Text(l10n.timeFormat),
                subtitle: Text(l10n.use24HourFormat),
                value: preferences.use24HourFormat,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier)
                      .setUse24HourFormat(value);
                },
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${l10n.failed_to_load_language_settings}:\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}