import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/providers/base_provider.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/services/stats_service.dart';

/// 统计提供者
class StatsProvider extends BaseProvider {
  final StatsService _statsService;

  /// 最近播放曲目
  ValueNotifier<List<PlayStatsInterface>> recentPlays = ValueNotifier([]);

  /// 最常播放曲目
  ValueNotifier<List<PlayStatsInterface>> topTracks = ValueNotifier([]);

  /// 最常播放艺术家
  ValueNotifier<List<ArtistStatsInterface>> topArtists = ValueNotifier([]);

  /// 总播放时长(秒)
  ValueNotifier<int> totalPlayDuration = ValueNotifier(0);

  /// 总播放次数
  ValueNotifier<int> totalPlayCount = ValueNotifier(0);

  /// 构造函数
  StatsProvider(this._statsService);

  /// 记录曲目播放
  Future<PlayStatsInterface?> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false}) async {
    try {
      final stats = await _statsService.recordPlay(track,
          duration: duration, isComplete: isComplete);
      await loadStats(); // 刷新统计数据
      return stats;
    } catch (e) {
      debugPrint('记录播放失败: $e');
      return null;
    }
  }

  /// 获取曲目播放统计
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    try {
      return await _statsService.getTrackStats(track);
    } catch (e) {
      debugPrint('获取曲目统计失败: $e');
      return null;
    }
  }

  /// 获取艺术家播放统计
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    try {
      return await _statsService.getArtistStats(artist);
    } catch (e) {
      debugPrint('获取艺术家统计失败: $e');
      return null;
    }
  }

  /// 加载统计数据
  Future<void> loadStats() async {
    try {
      // 加载最近播放
      final recent = await _statsService.getRecentPlays(limit: 20);
      recentPlays.value = recent;

      // 加载最常播放曲目
      final top = await _statsService.getTopTracks(limit: 20);
      topTracks.value = top;

      // 加载最常播放艺术家
      final artists = await _statsService.getTopArtists(limit: 20);
      topArtists.value = artists;

      // 加载总播放时长
      totalPlayDuration.value = await _statsService.getTotalPlayDuration();

      // 加载总播放次数
      totalPlayCount.value = await _statsService.getTotalPlayCount();
    } catch (e) {
      debugPrint('加载统计数据失败: $e');
    }
  }

  @override
  void dispose() {
    recentPlays.dispose();
    topTracks.dispose();
    topArtists.dispose();
    totalPlayDuration.dispose();
    totalPlayCount.dispose();
    super.dispose();
  }
}
