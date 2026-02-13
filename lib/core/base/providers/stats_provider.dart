import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/services/stats_service.dart';
import 'base_provider.dart';

/// Mixin for stats services
mixin StatsProviderMixin on BaseProviderMixin<StatsService> {
  /// 记录曲目播放
  Future<PlayStatsInterface?> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false}) async {
    try {
      final stats = await service.recordPlay(track,
          duration: duration, isComplete: isComplete);
      return stats;
    } catch (e) {
      return null;
    }
  }

  /// 获取曲目播放统计
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    try {
      return await service.getTrackStats(track);
    } catch (e) {
      return null;
    }
  }

  /// 获取艺术家播放统计
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    try {
      return await service.getArtistStats(artist);
    } catch (e) {
      return null;
    }
  }

  /// 获取最近播放
  Future<List<PlayStatsInterface>> getRecentPlays({int limit = 20}) async {
    try {
      return await service.getRecentPlays(limit: limit);
    } catch (e) {
      return [];
    }
  }

  /// 获取最常播放曲目
  Future<List<PlayStatsInterface>> getTopTracks({int limit = 20}) async {
    try {
      return await service.getTopTracks(limit: limit);
    } catch (e) {
      return [];
    }
  }

  /// 获取最常播放艺术家
  Future<List<ArtistStatsInterface>> getTopArtists({int limit = 20}) async {
    try {
      return await service.getTopArtists(limit: limit);
    } catch (e) {
      return [];
    }
  }

  /// 获取总播放时长
  Future<int> getTotalPlayDuration() async {
    try {
      return await service.getTotalPlayDuration();
    } catch (e) {
      return 0;
    }
  }

  /// 获取总播放次数
  Future<int> getTotalPlayCount() async {
    try {
      return await service.getTotalPlayCount();
    } catch (e) {
      return 0;
    }
  }
}

