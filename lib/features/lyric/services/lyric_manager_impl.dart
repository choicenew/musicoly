import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';

/// 歌词管理器实现
class LyricManagerImpl extends BaseService {
  final ServiceRegistry _serviceRegistry = ServiceRegistry();

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
    final plugins = availablePlugins;
    
    // 简单实现：按顺序尝试所有插件直到找到歌词
    for (final pluginId in plugins) {
      try {
        final plugin = _serviceRegistry.getService<LyricPlugin>(pluginId);
        if (plugin != null) {
          final lyric = await plugin.fetchLyric(trackId, metadata: metadata);
          if (lyric != null) return lyric;
        }
      } catch (e) {
        debugPrint('歌词插件 $pluginId 获取失败: $e');
      }
    }
    return null;
  }

  @override
  Future<void> initialize() async {
    debugPrint('初始化歌词管理器...');
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
    // 将来由插件负责保存逻辑
    return false;
  }
}
