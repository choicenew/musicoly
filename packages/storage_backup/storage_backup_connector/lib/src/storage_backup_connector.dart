import 'package:storage_backup_hub/storage_backup_hub.dart';
import 'package:storage_backup_driver/storage_backup_driver.dart';

class StorageBackupConnector {
  static final StorageBackupHubImpl hub = StorageBackupHubImpl();

  static void registerAll() {
    hub.registerDriver(LocalJsonBackupDriver());
  }
}
