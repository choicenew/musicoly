import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/about_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/accounts_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/appearance_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/cookie_import_export_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/desktop_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/developers_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/downloads_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/playback_settings.dart';
import 'package:pyro_music/features/language/pages/language_settings_page.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 账户设置
        const _SectionTitle(title: '账户'),
        const AccountsSettings(),

        // 外观设置
        const _SectionTitle(title: '外观'),
        const AppearanceSettings(),

        // 播放设置
        const _SectionTitle(title: '播放'),
        const PlaybackSettings(),

        // 下载设置
        const _SectionTitle(title: '下载'),
        const DownloadsSettings(),

        // 语言和地区设置
        _SectionTitle(title: l10n.language_region),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(l10n.language_region),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LanguageSettingsPage(),
              ),
            );
          },
        ),

        // 桌面设置
        const _SectionTitle(title: '桌面'),
        const DesktopSettings(),

        // 开发者选项
        const _SectionTitle(title: '开发者选项'),
        const DevelopersSettings(),

        // Cookie导入导出
        const _SectionTitle(title: 'Cookie管理'),
        const CookieImportExportSettings(),

        // 关于
        const _SectionTitle(title: '关于'),
        const AboutSettings(),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
