import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyro_music/collections/env.dart';
import 'package:url_launcher/url_launcher.dart';


// 新增Dio导入
import 'package:dio/dio.dart';

class UpdateService {
  static final Dio _dio = Dio();

  static Future<void> checkUpdate(
    BuildContext context, {
    required ReleaseChannel releaseChannel,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      
      if (releaseChannel == ReleaseChannel.nightly) {
        final response = await _dio.get(
          "https://api.github.com/repos/KRTirtho/pyro_music/actions/workflows/pyro_music-release-binary.yml/runs?status=success&per_page=1"
        );
        // 添加空值检查
        final runs = response.data?["workflow_runs"] as List? ?? [];
        if (runs.isEmpty) return;
        
        final buildNum = runs[0]["run_number"] as int;
        if (buildNum > int.parse(packageInfo.buildNumber)) {
          _showUpdateDialog(context, buildNum.toString());
        }
      } else {
        final response = await _dio.get(
          "https://api.github.com/repos/KRTirtho/pyro_music/releases/latest"
        );
        final latestVersion = response.data?["tag_name"]?.toString();
        if (latestVersion != null && latestVersion != "v${packageInfo.version}") {
          _showUpdateDialog(context, latestVersion);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('检查更新失败'))
      );
    }
  }

  static void _showUpdateDialog(BuildContext context, String version) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('发现新版本'),
        content: Text('当前版本: v${version}\n是否立即下载更新？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse(
                "https://github.com/KRTirtho/pyro_music/releases/latest"
              ));
            },
            child: const Text('下载'),
          ),
        ],
      ),
    );
  }
}