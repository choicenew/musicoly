import 'package:flutter/material.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';

import 'package:provider/provider.dart';
import 'package:pyro_music/presentation/widgets/color_scheme_picker_dialog.dart';

class AppearanceSettings extends StatelessWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<UserPreferencesProvider>();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('主题'),
              subtitle: const Text('选择应用的主题模式'),
              trailing: DropdownButton<ThemeMode>(
                value: preferences.themeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('跟随系统'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('浅色'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('深色'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<UserPreferencesProvider>().setThemeMode(value);
                  }
                },
              ),
            ),
            SwitchListTile(
              title: const Text('AMOLED模式'),
              subtitle: const Text('使用纯黑背景的深色主题'),
              value: preferences.amoledDarkTheme,
              onChanged: (value) {
                context.read<UserPreferencesProvider>().setAmoledDarkTheme(value);
              },
            ),
            SwitchListTile(
              title: const Text('同步专辑颜色'),
              subtitle: const Text('根据专辑封面同步界面颜色'),
              value: preferences.albumColorSync,
              onChanged: (value) {
                context.read<UserPreferencesProvider>().setAlbumColorSync(value);
              },
            ),
            ListTile(
              title: const Text('强调色'),
              subtitle: const Text('选择应用的强调色方案'),
              trailing: ColorChip(
                color: preferences.accentColorScheme,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const ColorSchemePickerDialog(),
                ),
              ),
            ),
          ],
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
