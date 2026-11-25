import 'package:storage_backup_protocol/storage_backup_protocol.dart';

class StorageBackupHubImpl {
  final List<StorageBackupDriver> _drivers = [];

  void registerDriver(StorageBackupDriver driver) {
    _drivers.add(driver);
  }

  List<StorageBackupDriver> get drivers => List.unmodifiable(_drivers);
}
