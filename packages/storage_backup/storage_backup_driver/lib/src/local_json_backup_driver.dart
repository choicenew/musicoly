import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:storage_backup_protocol/storage_backup_protocol.dart';

class LocalJsonBackupDriver implements StorageBackupDriver {
  @override
  String get driverId => 'local_json_backup';

  @override
  String get driverName => 'Local JSON Backup & Restore Driver';

  @override
  Future<bool> exportBackup(BackupEntity backup) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final backupDir = Directory('${dir.path}/musicoly_backups');
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }
      final timestamp = backup.exportDate.toIso8601String().replaceAll(':', '-');
      final file = File('${backupDir.path}/backup_$timestamp.json');

      final Map<String, dynamic> jsonMap = {
        'version': backup.version,
        'exportDate': backup.exportDate.toIso8601String(),
        'data': backup.data,
      };

      await file.writeAsString(jsonEncode(jsonMap));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BackupEntity?> importBackup() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final backupDir = Directory('${dir.path}/musicoly_backups');
      if (!await backupDir.exists()) return null;

      final files = backupDir.listSync().whereType<File>().where((f) => f.path.endsWith('.json')).toList();
      if (files.isEmpty) return null;

      // Sort by modified date descending
      files.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      final latestFile = files.first;

      final content = await latestFile.readAsString();
      final Map<String, dynamic> jsonMap = jsonDecode(content);

      return BackupEntity(
        version: jsonMap['version'] as String? ?? '1.0.0',
        exportDate: DateTime.parse(jsonMap['exportDate'] as String),
        data: jsonMap['data'] as Map<String, dynamic>? ?? {},
      );
    } catch (e) {
      return null;
    }
  }
}
