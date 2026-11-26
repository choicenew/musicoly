import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Smart Offline Cache & Auto-Download Manager (Finamp & Musify Inspired)
class SmartOfflineCacheDriver {
  Future<Directory> getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${appDir.path}/musicoly_offline_cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  }

  Future<bool> cacheTrackBytes(String trackId, List<int> bytes) async {
    try {
      final dir = await getCacheDirectory();
      final file = File('${dir.path}/track_$trackId.cache');
      await file.writeAsBytes(bytes);
      debugPrint('Track $trackId successfully cached offline (${bytes.length} bytes)');
      return true;
    } catch (e) {
      debugPrint('Error caching track $trackId: $e');
      return false;
    }
  }

  Future<File?> getCachedTrack(String trackId) async {
    try {
      final dir = await getCacheDirectory();
      final file = File('${dir.path}/track_$trackId.cache');
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      debugPrint('Error reading cached track $trackId: $e');
    }
    return null;
  }

  Future<void> clearCache() async {
    try {
      final dir = await getCacheDirectory();
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        debugPrint('Offline cache cleared successfully.');
      }
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }
}
