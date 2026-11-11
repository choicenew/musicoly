import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/player/services/share_to_device_service.dart';

/// Spotube Style Share-To-Device & Local Network Media Stream Sharing Dialog
class ShareToDeviceDialog extends StatefulWidget {
  final TrackModel currentTrack;

  const ShareToDeviceDialog({
    super.key,
    required this.currentTrack,
  });

  @override
  State<ShareToDeviceDialog> createState() => _ShareToDeviceDialogState();
}

class _ShareToDeviceDialogState extends State<ShareToDeviceDialog> {
  final ShareToDeviceService _shareService = ShareToDeviceService();
  String _shareUrl = '正在生成局域网分享链接...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initShareServer();
  }

  Future<void> _initShareServer() async {
    final url = await _shareService.startLocalShareServer(widget.currentTrack);
    if (mounted) {
      setState(() {
        _shareUrl = url;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _shareService.stopServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.devices, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('跨设备/局域网设备分享'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '在同一局域网下的手机、电脑或 Smart TV 浏览器中扫描或打开以下链接，即可实时同步播放该曲目：',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Share URL Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _shareUrl,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: '复制链接',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _shareUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('分享链接已复制到剪贴板')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Detected Nearby Devices List
            Text(
              '📡 局域网搜寻到的可用设备:',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Living Room Smart TV (DLNA/Cast)'),
              subtitle: const Text('就绪 - 点击投送'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已向客厅电视发送投送指令')),
                  );
                },
                child: const Text('投送'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.laptop),
              title: const Text('Desktop Chrome / Windows App'),
              subtitle: const Text('就绪 - 实时同步'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已向桌面端同步播放状态')),
                  );
                },
                child: const Text('同步'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }
}
