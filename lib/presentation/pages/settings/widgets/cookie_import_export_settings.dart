import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';
import 'package:pyro_music/core/base/services/auth_service.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class CookieImportExportSettings extends StatelessWidget {
  const CookieImportExportSettings({super.key});

  Future<void> _handleImport(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result == null || result.files.isEmpty) return;

      final platformRegistry = PlatformRegistry();
      final authServices = platformRegistry.getAllServicesOfType<AuthService>();
      
      final file = result.files.single;
      final jsonData = String.fromCharCodes(file.bytes!);
      
      for (final entry in authServices.entries) {
        final authService = entry.value;
        await authService.loginWithToken(jsonData);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cookie_import_success)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.import_failed(e.toString()))),
        );
      }
    }
  }

  Future<void> _handleExport(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final platformRegistry = PlatformRegistry();
      final authServices = platformRegistry.getAllServicesOfType<AuthService>();
      
      final exportData = <String, dynamic>{};
      
      for (final entry in authServices.entries) {
        final token = await entry.value.getToken();
        exportData[entry.key] = token;
      }
      
      final jsonData = jsonEncode(exportData);
      final path = await FilePicker.platform.saveFile(
        dialogTitle: l10n.export_cookie,
        fileName: 'pyro_music_cookies.json',
      );
      
      if (path != null) {
        await File(path).writeAsString(jsonData);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.cookie_export_success)),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.export_failed(e.toString()))),
        );
      }
    }
  }

  Future<void> _handleClear(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final platformRegistry = PlatformRegistry();
      final authServices = platformRegistry.getAllServicesOfType<AuthService>();
      
      for (final entry in authServices.entries) {
        await entry.value.signOut();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cookie_cleared)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.clear_failed(e.toString()))),
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
            ListTile(
              title: const Text('导入Cookie'),
              subtitle: const Text('从文件导入认证信息'),
              trailing: TextButton(
                onPressed: () => _handleImport(context),
                child: const Text('导入'),
              ),
            ),
            ListTile(
              title: const Text('导出Cookie'),
              subtitle: const Text('导出当前认证信息到文件'),
              trailing: TextButton(
                onPressed: () => _handleExport(context),
                child: const Text('导出'),
              ),
            ),
            ListTile(
              title: const Text('清除Cookie'),
              subtitle: const Text('清除所有平台的认证信息'),
              trailing: TextButton(
                onPressed: () => _handleClear(context),
                child: const Text('清除'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
