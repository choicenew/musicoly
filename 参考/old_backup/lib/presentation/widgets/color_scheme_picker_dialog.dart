import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';

class ColorSchemePickerDialog extends StatelessWidget {
  const ColorSchemePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<UserPreferencesProvider>(context);

    return AlertDialog(
      title: const Text('选择强调色'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: preferences.accentColorScheme,
          onColorChanged: (color) {
            preferences.setAccentColor(color);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('确定'),
        ),
      ],
    );
  }
}
