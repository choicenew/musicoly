import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/about_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/accounts_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/appearance_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/cookie_import_export_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/desktop_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/developers_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/downloads_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/language_region_settings.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/playback_settings.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 账户设置
        _SectionTitle(title: '账户'),
        AccountsSettings(),

        // 外观设置
        _SectionTitle(title: '外观'),
        AppearanceSettings(),

        // 播放设置
        _SectionTitle(title: '播放'),
        PlaybackSettings(),

        // 下载设置
        _SectionTitle(title: '下载'),
        DownloadsSettings(),

        // 语言和地区设置
        _SectionTitle(title: '语言和地区'),
        LanguageRegionSettings(),

        // 桌面设置
        _SectionTitle(title: '桌面'),
        DesktopSettings(),

        // 开发者选项
        _SectionTitle(title: '开发者选项'),
        DevelopersSettings(),

        // Cookie导入导出
        _SectionTitle(title: 'Cookie管理'),
        CookieImportExportSettings(),

        // 关于
        _SectionTitle(title: '关于'),
        AboutSettings(),
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
