import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// 智能边听边存离线缓存服务 (Audio Cache Manager)
class AudioCacheManager extends BaseService {
  Directory? _cacheDir;
  int _maxCacheSizeBytes = 2 * 1024 * 1024 * 1024; // 默认最大 2GB 缓存

  @override
  String get serviceId => 'audio_cache_manager';

  @override
  String get serviceName => 'Audio Cache Manager';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  Future<void> initializeCache() async {
    final docDir = await getApplicationDocumentsDirectory();
    _cacheDir = Directory('${docDir.path}/audio_cache');
    if (!await _cacheDir!.exists()) {
      await _cacheDir!.create(recursive: true);
    }
  }

  /// 检查某首歌曲是否已有离线缓存文件
  Future<File?> getCachedAudioFile(String trackId) async {
    if (_cacheDir == null) await initializeCache();
    final file = File('${_cacheDir!.path}/$trackId.mp3');
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// 保存/缓存音频字节流到本地
  Future<File> saveAudioToCache(String trackId, List<int> bytes) async {
    if (_cacheDir == null) await initializeCache();
    final file = File('${_cacheDir!.path}/$trackId.mp3');
    await file.writeAsBytes(bytes);
    debugPrint('Audio cached successfully for track: $trackId');
    
    // 异步清理超出大小限制的过期缓存
    _enforceMaxCacheSize();
    return file;
  }

  /// 获取当前已使用的缓存总大小（字节）
  Future<int> getTotalCacheSize() async {
    if (_cacheDir == null) await initializeCache();
    int totalSize = 0;
    if (await _cacheDir!.exists()) {
      final files = _cacheDir!.listSync();
      for (var f in files) {
        if (f is File) {
          totalSize += await f.length();
        }
      }
    }
    return totalSize;
  }

  /// 清空所有音频缓存
  Future<void> clearAllCache() async {
    if (_cacheDir == null) await initializeCache();
    if (await _cacheDir!.exists()) {
      final files = _cacheDir!.listSync();
      for (var f in files) {
        if (f is File) {
          await f.delete();
        }
      }
    }
    debugPrint('All audio cache cleared');
  }

  /// 超额清理机制：按最后修改时间（LRU）清理旧缓存文件
  Future<void> _enforceMaxCacheSize() async {
    if (_cacheDir == null) return;
    int currentSize = await getTotalCacheSize();
    if (currentSize > _maxCacheSizeBytes) {
      final files = _cacheDir!
          .listSync()
          .whereType<File>()
          .toList()
        ..sort((a, b) => a.lastModifiedSync().compareTo(b.lastModifiedSync()));

      for (var file in files) {
        if (currentSize <= _maxCacheSizeBytes) break;
        final fileSize = await file.length();
        await file.delete();
        currentSize -= fileSize;
      }
    }
  }
}
