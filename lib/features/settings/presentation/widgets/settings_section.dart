import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.bar_chart, color: Colors.purpleAccent),
            title: const Text('听歌统计与个人回顾报告'),
            subtitle: const Text('查看听歌总时长、播放次数与最热 Top 歌手/曲目'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/stats'),
          ),
        ),
        const AccountsSettings(),
        const Divider(),
        const AppearanceSettings(),
        const Divider(),
        const PlaybackSettings(),
        const Divider(),
        const EqualizerSettings(),
        const Divider(),
        const DownloadsSettings(),
        const Divider(),
        const ScrobblerSettings(),
        const Divider(),
        const BackupRestoreSettings(),
        const Divider(),
        const CookieImportExportSettings(),
        const Divider(),
        const DesktopSettings(),
        const Divider(),
        const DevelopersSettings(),
        const Divider(),
        const AboutSettings(),
      ],
    );
  }
}

