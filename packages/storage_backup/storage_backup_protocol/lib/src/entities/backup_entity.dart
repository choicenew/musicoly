import 'package:flutter/foundation.dart';

@immutable
class BackupEntity {
  final String version;
  final DateTime exportDate;
  final Map<String, dynamic> data;

  const BackupEntity({
    required this.version,
    required this.exportDate,
    required this.data,
  });
}
