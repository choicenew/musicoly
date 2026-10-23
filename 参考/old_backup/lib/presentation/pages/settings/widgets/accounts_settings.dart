import 'package:flutter/material.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';
import 'package:pyro_music/core/base/services/auth_service.dart';
import 'package:pyro_music/presentation/pages/mobile_login/mobile_login_page.dart';

class AccountsSettings extends StatefulWidget {
  const AccountsSettings({super.key});

  @override
  State<AccountsSettings> createState() => _AccountsSettingsState();
}

class _AccountsSettingsState extends State<AccountsSettings> {
  final PlatformRegistry _platformRegistry = PlatformRegistry();
  late Map<String, AuthService> _authServices;

  @override
  void initState() {
    super.initState();
    _authServices = _platformRegistry.getAllServicesOfType<AuthService>();
  }

  Future<void> _handlePlatformAuth(String platformId, AuthService authService) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const MobileLoginPage(),
      ),
    );

    if (result == true && mounted) {
      setState(() {});
    }
  }

  Future<void> _handleLogout(String platformId, AuthService authService) async {
    try {
      await authService.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${_platformRegistry.getPlatformInfo(platformId)?.displayName} 已登出')),
        );
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登出失败: $e')),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('账户管理', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ..._authServices.entries.map((entry) {
              final platformId = entry.key;
              final authService = entry.value;
              final platformInfo = _platformRegistry.getPlatformInfo(platformId);
              final user = authService.currentUser;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user?.imageUrl != null 
                    ? NetworkImage(user!.imageUrl!) 
                    : null,
                  child: user?.imageUrl == null 
                    ? Icon(_platformRegistry.getPlatformInfo(platformId)?.type == 'music_streaming'
                        ? Icons.music_note
                        : Icons.play_circle_filled)
                    : null,
                ),
                title: Text(platformInfo?.displayName ?? platformId),
                subtitle: user != null 
                  ? Text('已登录: ${user.displayName}')
                  : const Text('未登录'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _handlePlatformAuth(platformId, authService),
                onLongPress: () => _handleLogout(platformId, authService),
              );
            }),
          ],
        ),
      ),
    );
  }
}
