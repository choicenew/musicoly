import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/providers/stats_provider.dart' as base;
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/features/stats/services/play_stats_service_impl.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

/// 播放统计提供者实现
class PlayStatsProvider extends base.StatsProvider {
  final PlayerStateNotifier _playerStateProvider;
  final PlayStatsServiceImpl _playStatsService;

  /// Current playback state
  ValueNotifier<PlayerState> get playbackState =>
      ValueNotifier(_playerStateProvider.state);

  /// 当前曲目统计
  ValueNotifier<PlayStatsInterface?> currentTrackStats = ValueNotifier(null);

  /// 是否自动记录播放
  ValueNotifier<bool> autoRecordPlays = ValueNotifier(true);

  /// 完整播放阈值(百分比)
  ValueNotifier<double> completePlayThreshold = ValueNotifier(0.8);

  /// 构造函数
  PlayStatsProvider(
    this._playStatsService,
    this._playerStateProvider,
  ) : super(_playStatsService) {
    // 监听播放器状态变化
    _playerStateProvider.currentTrack.addListener(_onTrackChanged);
    _playerStateProvider.playbackState.addListener(_onPlaybackStateChanged);
  }

  /// 记录当前曲目播放
  Future<void> recordCurrentPlay({int? duration, bool? isComplete}) async {
    final track = _playerStateProvider.currentTrack.value;
    if (track == null) return;

    final actualDuration =
        duration ?? _playerStateProvider.position.value ~/ 1000;
    final actualIsComplete =
        isComplete ?? _isCompletePlay(track, actualDuration);

    final stats = await _playStatsService.recordPlay(
      track,
      duration: actualDuration,
      isComplete: actualIsComplete,
    );

    currentTrackStats.value = stats;
    await loadStats(); // 刷新统计数据
  }

  /// 判断是否为完整播放
  bool _isCompletePlay(TrackInterface track, int playedDuration) {
    if (track.durationMs <= 0) return false;

    final trackDurationSeconds = track.durationMs ~/ 1000;
    final threshold = trackDurationSeconds * completePlayThreshold.value;

    return playedDuration >= threshold;
  }

  /// 当前曲目变化处理
  void _onTrackChanged() {
    final track = _playerStateProvider.currentTrack.value;
    if (track == null) {
      currentTrackStats.value = null;
      return;
    }

    // 加载当前曲目的统计信息
    _loadCurrentTrackStats(track);
  }

  /// 播放状态变化处理
  void _onPlaybackStateChanged() {
    // 如果启用了自动记录，并且曲目播放结束，记录播放
    if (!autoRecordPlays.value) return;

    final isPlaying = _playerStateProvider.state.isPlaying;
    final track = _playerStateProvider.currentTrack.value;

    if (!isPlaying && track != null) {
      // 曲目暂停或结束时记录播放
      recordCurrentPlay();
    }
  }

  /// 加载当前曲目统计
  Future<void> _loadCurrentTrackStats(TrackInterface track) async {
    try {
      final stats = await _playStatsService.getTrackStats(track);
      currentTrackStats.value = stats;
    } catch (e) {
      debugPrint('加载当前曲目统计失败: $e');
      currentTrackStats.value = null;
    }
  }

  /// 切换自动记录播放
  void toggleAutoRecordPlays() {
    autoRecordPlays.value = !autoRecordPlays.value;
  }

  /// 设置完整播放阈值
  void setCompletePlayThreshold(double threshold) {
    if (threshold >= 0.0 && threshold <= 1.0) {
      completePlayThreshold.value = threshold;
    }
  }

  @override
  void dispose() {
    _playerStateProvider.currentTrack.removeListener(_onTrackChanged);
    _playerStateProvider.playbackState.removeListener(_onPlaybackStateChanged);
    currentTrackStats.dispose();
    autoRecordPlays.dispose();
    completePlayThreshold.dispose();
    super.dispose();
  }
}
