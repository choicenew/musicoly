import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';

class ColorSchemePickerDialog extends ConsumerWidget {
  const ColorSchemePickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(userPreferencesProvider);

    return preferencesAsync.when(
      data: (preferences) => AlertDialog(
        title: const Text('选择强调色'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: preferences.accentColor,
            onColorChanged: (color) {
              ref.read(userPreferencesProvider.notifier).setAccentColor(color);
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
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => AlertDialog(
        title: const Text('Error'),
        content: Text('$error'),
      ),
    );
  }
}
