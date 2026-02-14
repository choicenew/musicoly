import 'base_service.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';

/// 音轨源服务接口 - 插件化基础类
abstract class TrackSourceService extends BaseService {
  /// 插件标识 (例如 'youtube', 'piped')
  String get pluginId;

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track});

  /// 搜索音源
  Future<List<SourceInfo>> search(String query);
}

/// 音轨源管理器 - 负责管理所有音源插件
abstract class TrackSourceManager extends BaseService {
  /// 当前活跃的音源插件ID
  String get activePluginId;

  /// 获取所有已注册的音源插件
  List<String> get availablePlugins;

  /// 设置活跃音源插件
  void setActivePlugin(String pluginId);

  /// 获取活跃音源插件实例
  TrackSourceService? get activePlugin;

  /// 搜索音源 (聚合搜索或使用当前插件)
  Future<List<SourceInfo>> search(String query);

  /// 从轨道获取音源 (使用当前插件)
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track});
}
