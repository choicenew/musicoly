import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';
import 'package:pyro_music/presentation/widgets/color_scheme_picker_dialog.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class AppearanceSettings extends ConsumerWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final l10n = AppLocalizations.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: preferencesAsync.when(
          data: (preferences) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(l10n.theme),
                subtitle: Text(l10n.choose_theme_mode),
                trailing: DropdownButton<ThemeMode>(
                  value: preferences.themeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(l10n.follow_system),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(l10n.light_mode),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(l10n.dark_mode),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(userPreferencesProvider.notifier).setThemeMode(value);
                    }
                  },
                ),
              ),
              SwitchListTile(
                title: Text(l10n.amoled_mode),
                subtitle: Text(l10n.amoled_mode_description),
                value: preferences.amoledDark,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setAmoledDark(value);
                },
              ),
              SwitchListTile(
                title: Text(l10n.sync_album_color),
                subtitle: Text(l10n.sync_album_color_description),
                value: preferences.albumColorSync,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).setAlbumColorSync(value);
                },
              ),
              ListTile(
                title: Text(l10n.accent_color),
                subtitle: Text(l10n.choose_accent_color),
                trailing: ColorChip(
                  color: preferences.accentColor,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const ColorSchemePickerDialog(),
                  ),
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const ColorChip({
    super.key,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
