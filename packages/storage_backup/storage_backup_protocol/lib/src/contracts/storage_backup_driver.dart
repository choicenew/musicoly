import '../entities/backup_entity.dart';

abstract class StorageBackupDriver {
  String get driverId;
  String get driverName;
  Future<bool> exportBackup(BackupEntity backup);
  Future<BackupEntity?> importBackup();
}
