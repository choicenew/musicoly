import 'package:flutter/material.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('检查更新失败'))
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
                  title: const Text('版本信息'),
                  subtitle: Text(snapshot.hasData 
                    ? "v${snapshot.data!.version}"
                    : "加载中..."),
                  trailing: TextButton(
                    onPressed: _checkUpdate,
                    child: const Text('检查更新'), // 使用专用更新检查方法
                  ),
                ),
                ListTile(
                  title: const Text('项目仓库'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _launchUrl('https://github.com/KRTirtho/pyro_music'),
                ),
                ListTile(
                  title: const Text('问题反馈'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _launchUrl('https://github.com/KRTirtho/pyro_music/issues'),
                ),
                ListTile(
                  title: const Text('开源许可'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _launchUrl('https://raw.githubusercontent.com/KRTirtho/pyro_music/master/LICENSE'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '© ${DateTime.now().year} Pyro Music Team\n'
                    '基于Flutter构建的开源音乐播放器',
                    textAlign: TextAlign.center,
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
