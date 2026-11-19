import 'package:flutter/material.dart';

class PluginManagerPage extends StatelessWidget {
  const PluginManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动态插件中心 (Plugin Manager)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.extension_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('动态荷图(Hetu)脚本插件引擎已就绪'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_upload),
              label: const Text('导入 .ht 插件文件'),
            ),
          ],
        ),
      ),
    );
  }
}
