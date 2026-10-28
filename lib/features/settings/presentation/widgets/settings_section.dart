import 'package:flutter/material.dart';
import 'package:pyro_music/features/settings/presentation/widgets/about_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/accounts_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/appearance_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/cookie_import_export_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/desktop_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/developers_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/downloads_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/playback_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/equalizer_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/scrobbler_settings.dart';
import 'package:pyro_music/features/settings/presentation/widgets/backup_restore_settings.dart';

/// 设置模块主布局
class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: const [
        AccountsSettings(),
        Divider(),
        AppearanceSettings(),
        Divider(),
        PlaybackSettings(),
        Divider(),
        EqualizerSettings(),
        Divider(),
        DownloadsSettings(),
        Divider(),
        ScrobblerSettings(),
        Divider(),
        BackupRestoreSettings(),
        Divider(),
        CookieImportExportSettings(),
        Divider(),
        DesktopSettings(),
        Divider(),
        DevelopersSettings(),
        Divider(),
        AboutSettings(),
      ],
    );
  }
}
