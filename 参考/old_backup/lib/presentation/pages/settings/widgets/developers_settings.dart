import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DevelopersSettings extends StatefulWidget {
  const DevelopersSettings({super.key});

  @override
  State<DevelopersSettings> createState() => _DevelopersSettingsState();
}

class _DevelopersSettingsState extends State<DevelopersSettings> {
  bool _debugMode = false;
  bool _verboseLogging = false;
  String _apiEndpoint = '';

  Future<void> _cleanCache(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = Directory('${tempDir.path}/cache');
      
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('缓存清理完成')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('清理失败: $e')),
        );
      }
    }
  }

  Future<void> _showEndpointDialog(BuildContext context) async {
    final controller = TextEditingController(text: _apiEndpoint);
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('API端点配置'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'API服务器地址',
            hintText: 'https://api.example.com',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _apiEndpoint = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportLogs(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final logFile = File('${tempDir.path}/app.log');
      
      if (!await logFile.exists()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('没有可导出的日志')),
          );
        }
        return;
      }
      
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: '导出日志',
        fileName: 'pyro_music_logs.txt',
      );
      
      if (savePath != null) {
        await logFile.copy(savePath);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('日志导出成功')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('调试模式'),
              subtitle: const Text('启用开发者工具和详细日志'),
              value: _debugMode,
              onChanged: (value) {
                setState(() {
                  _debugMode = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('详细日志'),
              subtitle: const Text('记录更详细的应用日志'),
              value: _verboseLogging,
              onChanged: (value) {
                setState(() {
                  _verboseLogging = value;
                });
              },
            ),
            ListTile(
              title: const Text('API端点配置'),
              subtitle: Text(_apiEndpoint.isEmpty ? '使用默认服务器' : _apiEndpoint),
              trailing: TextButton(
                child: const Text('配置'),
                onPressed: () => _showEndpointDialog(context),
              ),
            ),
            ListTile(
              title: const Text('缓存管理'),
              subtitle: const Text('清理应用临时缓存数据'),
              trailing: TextButton(
                child: const Text('清理'),
                onPressed: () => _cleanCache(context),
              ),
            ),
            ListTile(
              title: const Text('导出日志'),
              subtitle: const Text('导出应用日志文件'),
              trailing: TextButton(
                child: const Text('导出'),
                onPressed: () => _exportLogs(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
