import 'package:flutter/material.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';
import 'package:pyro_music/core/base/services/auth_service.dart';
import 'package:pyro_music/presentation/pages/mobile_login/mobile_login_page.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class AccountsSettings extends StatefulWidget {
  const AccountsSettings({super.key});

  static const String routeName = '/accounts_settings';

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
    final l10n = AppLocalizations.of(context);
    try {
      await authService.signOut();
      if (mounted) {
        final platformName = _platformRegistry.getPlatformInfo(platformId)?.displayName ?? platformId;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.logged_out(platformName))),
        );
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.logout_failed(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(l10n.account_management, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  ? Text(l10n.logged_in(user.displayName))
                  : Text(l10n.not_logged_in),
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
