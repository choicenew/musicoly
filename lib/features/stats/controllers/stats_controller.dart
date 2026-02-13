import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/features/stats/providers/artist_stats_provider.dart';
import 'package:pyro_music/features/stats/providers/play_stats_provider.dart';

final statsControllerProvider = Provider((ref) => StatsController(ref));

/// 统计控制器
class StatsController {
  final Ref _ref;

  /// 构造函数
  StatsController(this._ref) {
    _initListeners();
  }

  /// 最近播放曲目
  final ValueNotifier<List<PlayStatsInterface>> recentPlays = ValueNotifier([]);

  /// 最常播放曲目
  final ValueNotifier<List<PlayStatsInterface>> topTracks = ValueNotifier([]);

  /// 最常播放艺术家
  final ValueNotifier<List<ArtistStatsInterface>> topArtists = ValueNotifier([]);

  /// 总播放时长(秒)
  final ValueNotifier<int> totalPlayDuration = ValueNotifier(0);

  /// 总播放次数
  final ValueNotifier<int> totalPlayCount = ValueNotifier(0);

  /// 当前曲目统计
  final ValueNotifier<PlayStatsInterface?> currentTrackStats = ValueNotifier(null);

  /// 当前艺术家统计
  final ValueNotifier<List<ArtistStatsInterface>> currentArtistStats = ValueNotifier([]);

  /// 是否自动记录播放
  final ValueNotifier<bool> autoRecordPlays = ValueNotifier(true);

  /// 完整播放阈值(百分比)
  final ValueNotifier<double> completePlayThreshold = ValueNotifier(0.8);

  void _initListeners() {
    _ref.listen(playStatsProvider, (previous, next) {
      if (previous?.recentPlays != next.recentPlays) {
        recentPlays.value = next.recentPlays;
      }
      if (previous?.topTracks != next.topTracks) {
        topTracks.value = next.topTracks;
      }
      if (previous?.totalPlayDuration != next.totalPlayDuration) {
        totalPlayDuration.value = next.totalPlayDuration;
      }
      if (previous?.totalPlayCount != next.totalPlayCount) {
        totalPlayCount.value = next.totalPlayCount;
      }
      if (previous?.currentTrackStats != next.currentTrackStats) {
        currentTrackStats.value = next.currentTrackStats;
      }
      if (previous?.autoRecordPlays != next.autoRecordPlays) {
        autoRecordPlays.value = next.autoRecordPlays;
      }
      if (previous?.completePlayThreshold != next.completePlayThreshold) {
        completePlayThreshold.value = next.completePlayThreshold;
      }
    });

    _ref.listen(artistStatsProvider, (previous, next) {
      if (previous?.topArtists != next.topArtists) {
        topArtists.value = next.topArtists;
      }
      if (previous?.currentArtistStats != next.currentArtistStats) {
        currentArtistStats.value = next.currentArtistStats;
      }
    });
  }

  /// 加载统计数据
  Future<void> loadStats() async {
    await _ref.read(playStatsProvider.notifier).loadStats();
    await _ref.read(artistStatsProvider.notifier).loadStats();
  }

  /// 记录当前曲目播放
  Future<void> recordCurrentPlay({int? duration, bool? isComplete}) async {
    await _ref.read(playStatsProvider.notifier).recordCurrentPlay(
        duration: duration, isComplete: isComplete);
  }

  /// 获取曲目播放统计
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    return await _ref.read(playStatsProvider.notifier).getTrackStats(track);
  }

  /// 获取艺术家播放统计
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    return await _ref.read(artistStatsProvider.notifier).getArtistStats(artist);
  }

  /// 切换自动记录播放
  void toggleAutoRecordPlays() {
    _ref.read(playStatsProvider.notifier).toggleAutoRecordPlays();
  }

  /// 设置完整播放阈值
  void setCompletePlayThreshold(double threshold) {
    _ref.read(playStatsProvider.notifier).setCompletePlayThreshold(threshold);
  }

  /// 格式化时长为时间字符串
  String formatDuration(int durationInSeconds) {
    final hours = durationInSeconds ~/ 3600;
    final minutes = (durationInSeconds % 3600) ~/ 60;
    final seconds = durationInSeconds % 60;

    if (hours > 0) {
      return '$hours小时${minutes > 0 ? ' $minutes分钟' : ''}';
    } else if (minutes > 0) {
      return '$minutes分钟${seconds > 0 ? ' $seconds秒' : ''}';
    } else {
      return '$seconds秒';
    }
  }

  void dispose() {
    recentPlays.dispose();
    topTracks.dispose();
    topArtists.dispose();
    totalPlayDuration.dispose();
    totalPlayCount.dispose();
    currentTrackStats.dispose();
    currentArtistStats.dispose();
    autoRecordPlays.dispose();
    completePlayThreshold.dispose();
  }
}
