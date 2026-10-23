import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';
import 'package:pyro_music/core/services/service_registry.dart';

/// 音源管理器实现 - 负责音源插件的动态加载与发现
class TrackSourceManagerImpl extends TrackSourceManager {
  final ServiceRegistry _serviceRegistry = ServiceRegistry();
  
  String _activePluginId = '';

  @override
  String get serviceId => 'track_source_manager';

  @override
  String get serviceName => '音源管理器';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  String get activePluginId => _activePluginId;

  @override
  List<String> get availablePlugins {
    return _serviceRegistry.getAvailablePlatforms<TrackSourceService>();
  }

  @override
  void setActivePlugin(String pluginId) {
    if (availablePlugins.contains(pluginId)) {
      _activePluginId = pluginId;
      debugPrint('设置活跃音源插件: $pluginId');
    }
  }

  @override
  TrackSourceService? get activePlugin {
    if (_activePluginId.isEmpty) {
      final plugins = availablePlugins;
      if (plugins.isNotEmpty) {
        _activePluginId = plugins.first;
      } else {
        return null;
      }
    }
    return _serviceRegistry.getService<TrackSourceService>(_activePluginId);
  }

  @override
  Future<List<SourceInfo>> search(String query) async {
    final plugin = activePlugin;
    if (plugin != null) {
      return await plugin.search(query);
    }
    return [];
  }

  @override
  Future<SourcedTrack> fetchFromTrack({required TrackModel track}) async {
    final plugin = activePlugin;
    if (plugin != null) {
      return await plugin.fetchFromTrack(track: track);
    }
    throw Exception('未找到可用的音源插件');
  }

  @override
  Future<void> initialize() async {
    debugPrint('初始化音源管理器...');
    // 可以在这里加载保存的活跃插件配置
  }
}
