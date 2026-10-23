import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package0/pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'scrobbler_manager.g.dart';

/// Scrobbler 管理器 - 负责管理和分发播放记录到各个插件
@Riverpod(keepAlive: true)
ScrobblerManager scrobblerManager(Ref ref) {
  return ServiceRegistry().getService<ScrobblerManager>('scrobbler_manager')!;
}

class ScrobblerManager extends BaseService {
  final ServiceRegistry _serviceRegistry = ServiceRegistry();
  
  /// 获取所有已注册的 Scrobbler 插件
  List<ScrobblerPlugin> getScrobblers() => _scrobblers;

  /// 获取所有已注册的 Scrobbler 插件 (私有)
  List<ScrobblerPlugin> get _scrobblers {
    return _serviceRegistry.getAvailablePlatforms<ScrobblerPlugin>()
        .map((id) => _serviceRegistry.getService<ScrobblerPlugin>(id))
        .whereType<ScrobblerPlugin>()
        .toList();
  }

  @override
  String get serviceId => 'scrobbler_manager';

  @override
  String get serviceName => 'Scrobbler Manager';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final statesJson = prefs.getString('scrobblerEnabledStates') ?? '{}';
    final states = Map<String, bool>.from(jsonDecode(statesJson));

    for (var scrobbler in _scrobblers) {
      if (states.containsKey(scrobbler.serviceId)) {
        await scrobbler.setEnabled(states[scrobbler.serviceId]!);
      }
      
      if (scrobbler.isEnabled) {
        await scrobbler.initialize();
      }
    }
  }

  /// 通知所有已启用的 Scrobbler 正在播放
  Future<void> notifyNowPlaying(TrackInterface track) async {
    for (var scrobbler in _scrobblers) {
      if (scrobbler.isEnabled) {
        try {
          await scrobbler.onNowPlaying(track);
        } catch (e) {
          debugPrint('Scrobbler (${scrobbler.serviceId}) notifyNowPlaying 错误: $e');
        }
      }
    }
  }

  /// 通知所有已启用的 Scrobbler 记录播放
  Future<void> notifyScrobble(TrackInterface track, {required int duration, required bool isComplete}) async {
    for (var scrobbler in _scrobblers) {
      if (scrobbler.isEnabled) {
        try {
          await scrobbler.onScrobble(track, duration: duration, isComplete: isComplete);
        } catch (e) {
          debugPrint('Scrobbler (${scrobbler.serviceId}) notifyScrobble 错误: $e');
        }
      }
    }
  }

  /// 处理深层链接 (用于 OAuth 回调等)
  Future<void> handleDeepLink(Uri uri) async {
    if (uri.scheme == 'pyromusic' && uri.path.startsWith('/auth/')) {
      final segments = uri.path.split('/');
      if (segments.length < 3) return;
      
      final pluginId = segments[2];
      final scrobbler = _serviceRegistry.getService<ScrobblerPlugin>(pluginId);
      
      if (scrobbler != null) {
        final token = uri.queryParameters['token'];
        if (token != null) {
          await scrobbler.handleAuthToken(token);
        }
      }
    }
  }

  @override
  Map<String, dynamic> getConfig() => {
    'pluginCount': _scrobblers.length,
    'plugins': _scrobblers.map((s) => s.serviceId).toList(),
  };

  @override
  List<Type> getDependencies() => [ServiceRegistry];

  @override
  ServiceStatus getStatus() => ServiceStatus.available;

  @override
  Future<void> dispose() async {
    for (var scrobbler in _scrobblers) {
      await scrobbler.dispose();
    }
    _scrobblers.clear();
    super.dispose();
  }
}
