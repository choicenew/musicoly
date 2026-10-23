import 'package:flutter/material.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyro_music/collections/env.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pyro_music/core/services/update_service.dart';

class AboutSettings extends StatefulWidget {
  const AboutSettings({super.key});

  @override
  State<AboutSettings> createState() => _AboutSettingsState();
}

class _AboutSettingsState extends State<AboutSettings> {
  late Future<PackageInfo> _packageInfo;

  @override
  void initState() {
    super.initState();
    _packageInfo = PackageInfo.fromPlatform();
  }

  Future<void> _checkUpdate() async {
    try {
      await UpdateService.checkUpdate(
        context,
        releaseChannel: ReleaseChannel.stable, // 从Env获取实际渠道
      );
    } catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.failed_to_check_for_updates))
      );
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<PackageInfo>(
      future: _packageInfo,
      builder: (context, snapshot) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(l10n.version_info),
                  subtitle: Text(snapshot.hasData
                      ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                      : snapshot.hasError
                          ? l10n.error(snapshot.error.toString())
                          : l10n.loading),
                  trailing: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _checkUpdate,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(l10n.repository),
                  onTap: () => _launchUrl('https://github.com/TirthoRoy/pyromusic'),
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: Text(l10n.bug_issues),
                  onTap: () => _launchUrl('https://github.com/TirthoRoy/pyromusic/issues'),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(l10n.license),
                  onTap: () => showLicensePage(context: context),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.pyro_music_description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
