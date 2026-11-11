import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'lyric_service.dart';

/// OuterTune Inspired LRU Cached & Priority-Resolved Lyric Manager Implementation
class LyricManagerImpl extends BaseService implements LyricManager {
  final ServiceRegistry _serviceRegistry = ServiceRegistry();
  final LinkedHashMap<String, LyricData> _lruCache = LinkedHashMap<String, LyricData>();
  final int _maxCacheSize = 10;

  @override
  String get serviceId => 'lyric_manager';

  @override
  String get serviceName => '歌词管理器';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  List<String> get availablePlugins {
    return _serviceRegistry.getAvailablePlatforms<LyricPlugin>();
  }

  @override
  Future<LyricData?> getLyric(String trackId,
      {Map<String, dynamic>? metadata}) async {
    // 1. 优先从 LRU 内存缓存中读取 (OuterTune 架构标准)
    if (_lruCache.containsKey(trackId)) {
      final cached = _lruCache.remove(trackId)!;
      _lruCache[trackId] = cached; // Refresh LRU order
      debugPrint('Lyric hit in LRU cache for: $trackId');
      return cached;
    }

    // 2. 依次查询可用插件
    final plugins = availablePlugins;
    for (final pluginId in plugins) {
      try {
        final plugin = _serviceRegistry.getService<LyricPlugin>(pluginId);
        if (plugin != null) {
          final lyric = await plugin.fetchLyric(trackId, metadata: metadata);
          if (lyric != null) {
            _addToCache(trackId, lyric);
            return lyric;
          }
        }
      } catch (e) {
        debugPrint('歌词插件 $pluginId 获取失败: $e');
      }
    }
    return null;
  }

  void _addToCache(String trackId, LyricData lyric) {
    if (_lruCache.length >= _maxCacheSize) {
      final oldestKey = _lruCache.keys.first;
      _lruCache.remove(oldestKey);
    }
    _lruCache[trackId] = lyric;
  }

  @override
  Future<void> initialize() async {
    debugPrint('初始化歌词管理器 (OuterTune LRU Cache Enabled)...');
  }

  @override
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0}) async {
    final List<LyricData> results = [];
    final plugins = availablePlugins;
    
    for (final pluginId in plugins) {
      try {
        final plugin = _serviceRegistry.getService<LyricPlugin>(pluginId);
        if (plugin != null) {
          final pluginResults = await plugin.searchLyrics(query, limit: limit, offset: offset);
          results.addAll(pluginResults);
        }
      } catch (e) {
        debugPrint('歌词插件 $pluginId 搜索失败: $e');
      }
    }
    return results;
  }

  @override
  Future<bool> saveLyric(String trackId, LyricData lyric) async {
    _addToCache(trackId, lyric);
    return true;
  }
}

