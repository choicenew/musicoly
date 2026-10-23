import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/services/backup_service.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class BackupRestoreSettings extends ConsumerWidget {
  const BackupRestoreSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final registry = ServiceRegistry();
    final backupService = registry.getService<BackupService>('backup_service')!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(theme, l10n.backup_restore),
        Card(
          child: Column(
            children: [
              _buildSettingTile(
                context,
                icon: Icons.upload,
                title: l10n.export_backup,
                subtitle: l10n.backup_description,
                onTap: () async {
                  try {
                    await backupService.exportBackup();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.backup_success)),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.backup_failed(e.toString()))),
                      );
                    }
                  }
                },
              ),
              const Divider(height: 1),
              _buildSettingTile(
                context,
                icon: Icons.download,
                title: l10n.import_backup,
                subtitle: l10n.restore_description,
                onTap: () async {
                  try {
                    await backupService.importBackup();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.restore_success)),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.restore_failed(e.toString()))),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: onTap,
    );
  }
}
