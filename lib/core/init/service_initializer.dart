import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/features/player/services/queue_service_impl.dart';
import 'package:pyro_music/features/player/services/playback_service_impl.dart';
import 'package:pyro_music/features/lyric/services/lyric_manager_impl.dart';
import 'package:pyro_music/features/track_source/services/track_source_manager_impl.dart';
import 'package:pyro_music/features/track_source/sources/local.dart';
import 'package:pyro_music/core/services/sleep_timer_service.dart';
import 'package:pyro_music/core/services/local_scanner_service.dart';
import 'package:pyro_music/core/services/backup_service.dart';
import 'package:pyro_music/core/services/equalizer_service.dart';
import 'package:pyro_music/core/services/desktop_service.dart';
import 'package:pyro_music/core/services/scrobbler_manager.dart';
import 'package:pyro_music/features/scrobbler/plugins/lastfm_scrobbler.dart';
import 'package:pyro_music/features/statistics/services/play_stats_service_impl.dart';
import 'package:metadata_god/metadata_god.dart';

import 'package:pyro_music/features/plugin/registry/plugin_dispatcher.dart';
import 'package:pyro_music/features/plugin/runtime/default_system_plugin.dart';
import 'package:pyro_music/features/plugin/runtime/subsonic_plugin.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';

import 'package:pyro_music/features/playlist/services/local_playlist_service.dart';
import 'package:pyro_music/features/playlist/services/playlist_service_impl.dart' as playlist_impl;

/// 系统服务初始化器
class ServiceInitializer {
  /// 初始化所有核心服务
  static Future<void> initialize(Isar isar) async {
    final registry = ServiceRegistry();
    final platformRegistry = PlatformRegistry();

    // 初始化 MetadataGod
    MetadataGod.initialize();

    // 0. 注册底层数据库
    GetIt.instance.registerSingleton<Isar>(isar);

    // 1. 注册基础核心插件 (如本地音源)
    registry.registerPlatformService<LocalTrackSourceService>(
      'local',
      () => LocalTrackSourceService(isar),
    );

    // 2. 注册核心服务工厂
    registry.registerServiceFactory<QueueServiceImpl>(
      'queue_service',
      () => QueueServiceImpl(),
    );

    // 3. 注册音源管理器 (初始为空，等待插件注入)
    registry.registerServiceFactory<TrackSourceManagerImpl>(
      'track_source_manager',
      () => TrackSourceManagerImpl(),
    );

    // 4. 注册歌词管理器
    registry.registerServiceFactory<LyricManagerImpl>(
      'lyric_manager',
      () => LyricManagerImpl(),
    );

    // 4.5 注册睡眠定时器
    registry.registerServiceFactory<SleepTimerService>(
      'sleep_timer',
      () => SleepTimerService(),
    );

    // 4.6 注册本地扫描器
    registry.registerServiceFactory<LocalScannerService>(
      'local_scanner',
      () => LocalScannerService(),
    );

    // 4.7 注册备份服务
    registry.registerServiceFactory<BackupService>(
      'backup_service',
      () => BackupService(),
    );

    // 4.8 注册均衡器服务
    registry.registerServiceFactory<EqualizerService>(
      'equalizer_service',
      () => EqualizerService(),
    );

    // 4.9 注册播放列表服务
    registry.registerPlatformService<LocalPlaylistService>(
      'local',
      () => LocalPlaylistService(isar),
    );

    registry.registerServiceFactory<playlist_impl.PlaylistServiceImpl>(
      'playlist_service',
      () {
        final localService = registry.getService<LocalPlaylistService>('local');
        return playlist_impl.PlaylistServiceImpl(
          platformServices: localService != null ? [localService] : [],
        );
      },
    );

    // 5. 注册播放器平台服务 (Native)
    registry.registerPlatformService<PlaybackServiceImpl>(
      'native',
      () => PlaybackServiceImpl(),
    );

    // 6. 注册统一播放器服务
    registry.registerServiceFactory<PlayerServiceImpl>(
      'player_service',
      () => PlayerServiceImpl(),
    );

    // 自动发现并注册（会调用 initialize 方法）
    await registry.autoDiscoverAndRegister();

    // 设置默认活跃平台
    platformRegistry.activePlatformId = 'native';

    // 4.10 注册桌面集成服务
    registry.registerServiceFactory<DesktopService>(
      'desktop_service',
      () => DesktopService(),
    );

    // 4.11 注册播放统计服务
    registry.registerServiceFactory<PlayStatsServiceImpl>(
      'play_stats_service',
      () => PlayStatsServiceImpl(),
    );

    // 4.12 注册 Scrobbler 管理器
    registry.registerServiceFactory<ScrobblerManager>(
      'scrobbler_manager',
      () => ScrobblerManager(),
    );

    // 4.13 注册 Scrobbler 插件 (将来可动态加载)
    registry.registerPlatformService<LastfmScrobbler>(
      'lastfm',
      () => LastfmScrobbler(),
    );

    // 5. 启动基础服务
    final playerService = registry.getService<BaseService>('player_service');
    if (playerService != null) {
      await playerService.initialize();
    }

    // 初始化桌面服务
    final desktopService = registry.getService<BaseService>('desktop_service');
    if (desktopService != null) {
      await desktopService.initialize();
    }

    // 初始化统计服务
    final statsService = registry.getService<BaseService>('play_stats_service');
    if (statsService != null) {
      await statsService.initialize();
    }

    // 初始化 Scrobbler 管理器
    final scrobblerManager = registry.getService<BaseService>('scrobbler_manager');
    if (scrobblerManager != null) {
      await scrobblerManager.initialize();
    }

    // 4.14 注册通用插件注册中心与调度分发引擎
    final pluginRegistry = PluginRegistry();
    final systemPlugin = DefaultSystemPlugin();
    final subsonicPlugin = SubsonicPlugin();

    pluginRegistry.registerPlugin(systemPlugin);
    pluginRegistry.registerPlugin(subsonicPlugin);

    GetIt.instance.registerSingleton<PluginRegistry>(pluginRegistry);
    GetIt.instance.registerSingleton<PluginDispatcher>(PluginDispatcher(registry: pluginRegistry));

    debugPrint('核心服务初始化完成 (Pure Core)');
  }
}
