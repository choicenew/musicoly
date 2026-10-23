import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_music/features/auth/presentation/mobile_login_page.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// 账户设置小部件
class AccountsSettings extends ConsumerWidget {
  const AccountsSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            l10n.accounts,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: Text(l10n.user_account),
          subtitle: const Text('Not logged in'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MobileLoginPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.music_note_outlined),
          title: const Text('Last.fm Account'),
          subtitle: const Text('Connect to scrobble tracks'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/lastfm-login'),
        ),
      ],
    );
  }
}
