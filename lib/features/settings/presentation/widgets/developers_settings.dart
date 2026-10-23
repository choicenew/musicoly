import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = Directory('${tempDir.path}/cache');
      
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cache_cleared)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.clearing_failed(e.toString()))),
        );
      }
    }
  }

  Future<void> _showEndpointDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(text: _apiEndpoint);
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.api_endpoint_config),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.api_server_address,
            hintText: 'https://api.example.com',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _apiEndpoint = controller.text;
              });
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  Future<void> _exportLogs(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      final tempDir = await getTemporaryDirectory();
      final logFile = File('${tempDir.path}/app.log');
      
      if (!await logFile.exists()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.no_logs_to_export)),
          );
        }
        return;
      }
      
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: l10n.export_logs,
        fileName: 'pyro_music_logs.txt',
      );
      
      if (savePath != null) {
        await logFile.copy(savePath);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.logs_exported(savePath))),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text(l10n.debug_mode),
              subtitle: Text(l10n.debug_mode_description),
              value: _debugMode,
              onChanged: (value) {
                setState(() {
                  _debugMode = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(l10n.verbose_logging),
              subtitle: Text(l10n.verbose_logging_description),
              value: _verboseLogging,
              onChanged: (value) {
                setState(() {
                  _verboseLogging = value;
                });
              },
            ),
            ListTile(
              title: Text(l10n.api_endpoint_config),
              subtitle: Text(_apiEndpoint.isEmpty ? l10n.use_default_server : _apiEndpoint),
              trailing: TextButton(
                child: Text(l10n.configure),
                onPressed: () => _showEndpointDialog(context),
              ),
            ),
            ListTile(
              title: Text(l10n.cache_management),
              subtitle: Text(l10n.cache_management_description),
              trailing: TextButton(
                child: Text(l10n.clear),
                onPressed: () => _cleanCache(context),
              ),
            ),
            ListTile(
              title: Text(l10n.export_logs),
              subtitle: Text(l10n.export_logs_description),
              trailing: TextButton(
                child: Text(l10n.export),
                onPressed: () => _exportLogs(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
