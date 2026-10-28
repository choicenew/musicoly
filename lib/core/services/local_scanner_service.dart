import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:get_it/get_it.dart';

class LocalScannerService extends BaseService {
  bool _isScanning = false;
  bool get isScanning => _isScanning;

  @override
  String get serviceId => 'local_scanner';

  @override
  String get serviceName => 'Local Music Scanner';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  Future<void> deleteTracks(List<String> trackIds) async {
    final isar = GetIt.instance<Isar>();
    await isar.writeTxn(() async {
      for (final id in trackIds) {
        await isar.trackEntitys.filter().trackIdEqualTo(id).deleteAll();
      }
    });
  }

  Future<void> updateMetadata(String trackId, Metadata metadata) async {
    final isar = GetIt.instance<Isar>();
    final track = await isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    if (track != null && track.localPath != null) {
      await MetadataGod.writeMetadata(file: track.localPath!, metadata: metadata);
      // 同时更新数据库
      await isar.writeTxn(() async {
        track.name = metadata.title ?? track.name;
        track.artistNames = [metadata.artist ?? track.artistNames?.first ?? 'Unknown Artist'];
        track.albumName = metadata.album ?? track.albumName;
        await isar.trackEntitys.put(track);
      });
    }
  }

  @override
  Future<void> initialize() async {}

  Future<void> scan() async {
    if (_isScanning) return;
    _isScanning = true;

    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          debugPrint('Storage permission denied');
          return;
        }
      }

      final List<Directory> scanDirs = [];
      if (Platform.isAndroid) {
        // Android 常见音乐目录
        scanDirs.add(Directory('/storage/emulated/0/Music'));
        scanDirs.add(Directory('/storage/emulated/0/Download'));
      } else {
        final musicDir = await getExternalStorageDirectory(); // This is just an example
        if (musicDir != null) scanDirs.add(musicDir);
      }

      final isar = GetIt.instance<Isar>();
      
      for (final dir in scanDirs) {
        if (await dir.exists()) {
          await _scanDirectory(dir, isar);
        }
      }
    } catch (e) {
      debugPrint('Scan error: $e');
    } finally {
      _isScanning = false;
    }
  }

  Future<void> _scanDirectory(Directory dir, Isar isar) async {
    await for (final entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        final ext = p.extension(entity.path).toLowerCase();
        if (['.mp3', '.m4a', '.flac', '.wav'].contains(ext)) {
          await _processFile(entity, isar);
        }
      }
    }
  }

  Future<void> _processFile(File file, Isar isar) async {
    try {
      // 检查是否已经存在
      final existing = await isar.trackEntitys.filter().localPathEqualTo(file.path).findFirst();
      if (existing != null) return;

      final metadata = await MetadataGod.readMetadata(file: file.path);
      
      final track = TrackEntity()
        ..trackId = 'local_${DateTime.now().microsecondsSinceEpoch}_${file.path.hashCode}'
        ..name = metadata.title ?? p.basenameWithoutExtension(file.path)
        ..artistNames = [metadata.artist ?? 'Unknown Artist']
        ..albumName = metadata.album
        ..durationMs = metadata.duration?.inMilliseconds ?? 0
        ..localPath = file.path
        ..imageUrl = null; // Local images are harder to extract directly to URL

      await isar.writeTxn(() async {
        await isar.trackEntitys.put(track);
      });
      
      debugPrint('Scanned: ${track.name}');
    } catch (e) {
      debugPrint('Error processing ${file.path}: $e');
    }
  }
}
