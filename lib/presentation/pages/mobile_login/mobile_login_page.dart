import 'package:flutter/material.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';
import 'package:pyro_music/core/base/services/auth_service.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// 移动端登录页面
class MobileLoginPage extends StatefulWidget {
  /// 构造函数
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final PlatformRegistry _platformRegistry = PlatformRegistry();
  final List<String> _availablePlatforms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvailablePlatforms();
  }

  Future<void> _loadAvailablePlatforms() async {
    setState(() {
      _isLoading = true;
    });

    // 获取所有可用平台
    final platforms = _platformRegistry.availablePlatforms;
    final availablePlatforms = <String>[];

    // 检查每个平台是否提供认证服务
    for (final platformId in platforms) {
      // 使用正确的方法名称
      if (_platformRegistry.hasService<AuthService>(platformId)) {
        availablePlatforms.add(platformId);
      }
    }

    setState(() {
      _availablePlatforms.addAll(availablePlatforms);
      _isLoading = false;
    });
  }

  Future<void> _loginWithPlatform(String platformId) async {
    final l10n = AppLocalizations.of(context);
    try {
      // 设置活跃平台
      _platformRegistry.activePlatformId = platformId;
      
      // 获取平台的认证服务，使用正确的方法名称
      final authService = _platformRegistry.getServiceInstance<AuthService>(platformId);
      
      if (authService == null) {
        _showErrorDialog(l10n.failed_to_get_auth_service(_getPlatformName(platformId)));
        return;
      }

      // 执行OAuth登录
      await authService.loginWithOAuth();
      
      // 登录成功，返回上一页
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _showErrorDialog(l10n.login_failed(e.toString()));
    }
  }

  // 从平台元数据获取平台名称，而不是硬编码
  String _getPlatformName(String platformId) {
    final platformInfo = _platformRegistry.getPlatformInfo(platformId);
    return platformInfo?.displayName ?? platformId;
  }

  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.login_error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择登录平台'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _availablePlatforms.isEmpty
              ? _buildNoPlatformsView()
              : _buildPlatformList(),
    );
  }

  Widget _buildNoPlatformsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              '没有可用的音乐平台',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '请确保至少有一个音乐平台已正确配置',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadAvailablePlatforms,
              child: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _availablePlatforms.length,
      itemBuilder: (context, index) {
        final platformId = _availablePlatforms[index];
        final platformName = _getPlatformName(platformId);
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: Icon(_getPlatformIcon(platformId)),
            title: Text(platformName),
            subtitle: Text('登录到$platformName以访问您的音乐'),
            trailing: const Icon(Icons.login),
            onTap: () => _loginWithPlatform(platformId),
          ),
        );
      },
    );
  }

  // 从平台元数据获取图标，而不是硬编码
  IconData _getPlatformIcon(String platformId) {
    final platformInfo = _platformRegistry.getPlatformInfo(platformId);
    // 根据平台类型返回适当的图标
    if (platformInfo?.type == 'music_streaming') {
      return Icons.music_note;
    } else if (platformInfo?.type == 'video_streaming') {
      return Icons.play_circle_filled;
    }
    return Icons.music_note; // 默认图标
  }
}
