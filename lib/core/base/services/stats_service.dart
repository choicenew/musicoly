import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';

/// 统计服务接口
abstract class StatsService extends BaseService {
  /// 记录曲目播放
  Future<PlayStatsInterface> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false});

  /// 获取曲目播放统计
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track);

  /// 获取艺术家播放统计
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist);

  /// 获取最近播放曲目
  Future<List<PlayStatsInterface>> getRecentPlays(
      {int limit = 20, int offset = 0});

  /// 获取最常播放曲目
  Future<List<PlayStatsInterface>> getTopTracks(
      {int limit = 20, int offset = 0});

  /// 获取最常播放艺术家
  Future<List<ArtistStatsInterface>> getTopArtists(
      {int limit = 20, int offset = 0});

  /// 获取总播放时长(秒)
  Future<int> getTotalPlayDuration();

  /// 获取总播放次数
  Future<int> getTotalPlayCount();
}
