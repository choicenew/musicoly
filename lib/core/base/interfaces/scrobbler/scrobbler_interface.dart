import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/services/base_service.dart';

/// Scrobbler 插件信息
class ScrobblerPluginInfo {
  final String id;
  final String name;
  final String author;
  final String version;
  final String? description;
  final String? iconUrl;

  const ScrobblerPluginInfo({
    required this.id,
    required this.name,
    required this.author,
    required this.version,
    this.description,
    this.iconUrl,
  });
}

/// Scrobbler 接口 - 定义记录播放状态的通用标准
/// 现在作为 BaseService 的子类，支持通过 ServiceRegistry 动态加载
abstract class ScrobblerPlugin extends BaseService {
  /// 插件基本信息
  ScrobblerPluginInfo get pluginInfo;

  /// 插件 ID (对应 BaseService 的 serviceId)
  @override
  String get serviceId => pluginInfo.id;

  /// 插件名称 (对应 BaseService 的 serviceName)
  @override
  String get serviceName => pluginInfo.name;

  /// 插件版本 (对应 BaseService 的 serviceVersion)
  @override
  String get serviceVersion => pluginInfo.version;

  /// 插件是否已启用 (由管理器控制)
  bool get isEnabled;

  /// 设置插件启用状态
  Future<void> setEnabled(bool enabled);

  /// 当歌曲开始播放时调用 (用于设置 "Now Playing")
  Future<void> onNowPlaying(TrackInterface track);

  /// 当歌曲播放完成或达到 Scrobble 条件时调用
  /// [duration] 是实际播放时长 (秒)
  /// [isComplete] 是否完整播放完成
  Future<void> onScrobble(TrackInterface track, {required int duration, required bool isComplete});

  /// 是否已认证 (需要用户登录)
  bool get isAuthenticated;

  /// 认证/登录
  Future<void> authenticate();

  /// 退出登录
  Future<void> logout();

  /// 处理 OAuth 等回调 Token
  Future<void> handleAuthToken(String token);
}
