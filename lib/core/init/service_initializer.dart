import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/base/interfaces/player/queue_interface.dart';
import 'package:pyro_music/features/player/services/queue_service_impl.dart';
import 'package:pyro_music/features/player/services/playback_service_impl.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/features/lyric/services/lyric_manager_impl.dart';
import 'package:pyro_music/features/track_source/services/track_source_manager_impl.dart';
import 'package:pyro_music/features/track_source/sources/local.dart';

import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/platform/platform_registry.dart';

/// 系统服务初始化器
class ServiceInitializer {
  /// 初始化所有核心服务
  static Future<void> initialize(Isar isar) async {
    final registry = ServiceRegistry();
    final platformRegistry = PlatformRegistry();

    // 0. 注册底层数据库
    GetIt.instance.registerSingleton<Isar>(isar);

    // 1. 注册基础核心插件 (如本地音源)
    registry.registerPlatformService<TrackSourceService>(
      'local',
      () => LocalTrackSourceService(isar),
    );

    // 2. 注册核心服务工厂
    registry.registerServiceFactory<QueueInterface>(
      'queue_service',
      () => QueueServiceImpl(),
    );

    // 3. 注册音源管理器 (初始为空，等待插件注入)
    registry.registerServiceFactory<TrackSourceManager>(
      'track_source_manager',
      () => TrackSourceManagerImpl(),
    );

    // 4. 注册歌词管理器
    registry.registerServiceFactory<LyricManager>(
      'lyric_manager',
      () => LyricManagerImpl(),
    );

    // 5. 注册播放器平台服务 (Native)
    registry.registerPlatformService<PlayerService>(
      'native',
      () => PlaybackServiceImpl(),
    );

    // 6. 注册统一播放器服务
    registry.registerServiceFactory<PlayerService>(
      'player_service',
      () => PlayerServiceImpl(),
    );

    // 设置默认活跃平台
    if (platformRegistry.activePlatformId.isEmpty) {
      // 临时直接设置，因为 platformRegistry.activePlatformId 需要 availablePlatforms 包含它
      // 我们先完成 autoDiscoverAndRegister
    }

    // 自动发现并注册（会调用 initialize 方法）
    await registry.autoDiscoverAndRegister();

    // 设置默认活跃平台
    platformRegistry.activePlatformId = 'native';

    debugPrint('核心服务初始化完成 (Pure Core)');
  }
}
