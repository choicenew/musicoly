import 'package:storage_backup_protocol/storage_backup_protocol.dart';

class LocalJsonBackupDriver implements StorageBackupDriver {
  @override
  String get driverId => 'local_json_backup';

  @override
  String get driverName => 'Local JSON Backup & Restore Driver';

  @override
  Future<bool> exportBackup(BackupEntity backup) async {
    return true;
  }

  @override
  Future<BackupEntity?> importBackup() async {
    return null;
  }
}
