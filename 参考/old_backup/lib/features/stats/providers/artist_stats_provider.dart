import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/providers/stats_provider.dart' as base;
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/features/stats/services/artist_stats_service_impl.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

/// 艺术家统计提供者实现
class ArtistStatsProvider extends base.StatsProvider {
  final PlayerStateNotifier _playerStateProvider;
  final ArtistStatsServiceImpl _artistStatsService;

  /// 当前艺术家统计
  ValueNotifier<List<ArtistStatsInterface>> currentArtistStats =
      ValueNotifier([]);

  /// 构造函数
  ArtistStatsProvider(
    this._artistStatsService,
    this._playerStateProvider,
  ) : super(_artistStatsService) {
    // 监听播放器状态变化
    _playerStateProvider.currentTrack.addListener(_onTrackChanged);
  }

  /// 当前曲目变化处理
  void _onTrackChanged() {
    final track = _playerStateProvider.currentTrack.value;
    if (track == null || track.artistIds.isEmpty) {
      currentArtistStats.value = [];
      return;
    }

    // 加载当前曲目艺术家的统计信息
    _loadCurrentArtistStats(track.artistIds, track.artistNames);
  }

  /// 加载当前艺术家统计
  Future<void> _loadCurrentArtistStats(
      List<String> artistIds, List<String> artistNames) async {
    try {
      final statsList = <ArtistStatsInterface>[];

      for (int i = 0; i < artistIds.length; i++) {
        // 创建艺术家对象
        final artist = ArtistModel(
          id: artistIds[i],
          platform: 'spotify', // 假设平台是spotify
          name: i < artistNames.length ? artistNames[i] : 'Unknown Artist',
        );

        final stats = await _artistStatsService.getArtistStats(artist);
        if (stats != null) {
          statsList.add(stats);
        }
      }

      currentArtistStats.value = statsList;
    } catch (e) {
      debugPrint('加载当前艺术家统计失败: $e');
      currentArtistStats.value = [];
    }
  }

  /// 获取艺术家播放统计
  @override
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    try {
      return await _artistStatsService.getArtistStats(artist);
    } catch (e) {
      debugPrint('获取艺术家统计失败: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _playerStateProvider.currentTrack.removeListener(_onTrackChanged);
    currentArtistStats.dispose();
    super.dispose();
  }
}
