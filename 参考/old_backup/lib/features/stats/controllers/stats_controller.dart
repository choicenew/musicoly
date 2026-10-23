import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/features/stats/providers/play_stats_provider.dart';
import 'package:pyro_music/features/stats/providers/artist_stats_provider.dart';

/// 统计控制器
class StatsController {
  final PlayStatsProvider _playStatsProvider;
  final ArtistStatsProvider _artistStatsProvider;

  /// 构造函数
  StatsController(
    this._playStatsProvider,
    this._artistStatsProvider,
  ) {
    // 初始加载统计数据
    loadStats();
  }

  /// 最近播放曲目
  ValueNotifier<List<PlayStatsInterface>> get recentPlays =>
      _playStatsProvider.recentPlays;

  /// 最常播放曲目
  ValueNotifier<List<PlayStatsInterface>> get topTracks =>
      _playStatsProvider.topTracks;

  /// 最常播放艺术家
  ValueNotifier<List<ArtistStatsInterface>> get topArtists =>
      _artistStatsProvider.topArtists;

  /// 总播放时长(秒)
  ValueNotifier<int> get totalPlayDuration =>
      _playStatsProvider.totalPlayDuration;

  /// 总播放次数
  ValueNotifier<int> get totalPlayCount => _playStatsProvider.totalPlayCount;

  /// 当前曲目统计
  ValueNotifier<PlayStatsInterface?> get currentTrackStats =>
      _playStatsProvider.currentTrackStats;

  /// 当前艺术家统计
  ValueNotifier<List<ArtistStatsInterface>> get currentArtistStats =>
      _artistStatsProvider.currentArtistStats;

  /// 是否自动记录播放
  ValueNotifier<bool> get autoRecordPlays => _playStatsProvider.autoRecordPlays;

  /// 完整播放阈值(百分比)
  ValueNotifier<double> get completePlayThreshold =>
      _playStatsProvider.completePlayThreshold;

  /// 加载统计数据
  Future<void> loadStats() async {
    await _playStatsProvider.loadStats();
  }

  /// 记录当前曲目播放
  Future<void> recordCurrentPlay({int? duration, bool? isComplete}) async {
    await _playStatsProvider.recordCurrentPlay(
        duration: duration, isComplete: isComplete);
  }

  /// 获取曲目播放统计
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    return await _playStatsProvider.getTrackStats(track);
  }

  /// 获取艺术家播放统计
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    return await _artistStatsProvider.getArtistStats(artist);
  }

  /// 切换自动记录播放
  void toggleAutoRecordPlays() {
    _playStatsProvider.toggleAutoRecordPlays();
  }

  /// 设置完整播放阈值
  void setCompletePlayThreshold(double threshold) {
    _playStatsProvider.setCompletePlayThreshold(threshold);
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
}
