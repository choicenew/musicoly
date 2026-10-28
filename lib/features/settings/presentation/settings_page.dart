import 'package:flutter/material.dart';
import 'package:pyro_music/features/settings/presentation/widgets/settings_section.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// 应用设置页面
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: const SettingsSection(),
    );
  }
}
