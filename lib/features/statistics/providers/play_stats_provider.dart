import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/stats_model.dart';
import 'package:pyro_music/features/statistics/services/play_stats_service_impl.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

part 'play_stats_provider.freezed.dart';
part 'play_stats_provider.g.dart';

@freezed
abstract class PlayStatsState with _$PlayStatsState {
  const factory PlayStatsState({
    PlayStatsModel? currentTrackStats,
    @Default([]) List<PlayStatsModel> recentPlays,
    @Default([]) List<PlayStatsModel> topTracks,
    @Default(0) int totalPlayDuration,
    @Default(0) int totalPlayCount,
    @Default(true) bool autoRecordPlays,
    @Default(0.8) double completePlayThreshold,
  }) = _PlayStatsState;
}

/// 播放统计提供者实现
@Riverpod(keepAlive: true)
class PlayStatsNotifier extends _$PlayStatsNotifier {
  late final PlayStatsServiceImpl _serviceImpl;

  @override
  PlayStatsState build() {
    _serviceImpl = PlayStatsServiceImpl();
    _init();
    
    _listenToPlayerState();

    return const PlayStatsState();
  }

  Future<void> _init() async {
    await _serviceImpl.initialize();
    await loadStats();
  }

  /// 加载统计数据
  Future<void> loadStats() async {
    try {
      final recent = await _serviceImpl.getRecentPlays();
      final top = await _serviceImpl.getTopTracks();
      final duration = await _serviceImpl.getTotalPlayDuration();
      final count = await _serviceImpl.getTotalPlayCount();

      state = state.copyWith(
        recentPlays: recent,
        topTracks: top,
        totalPlayDuration: duration,
        totalPlayCount: count,
      );
    } catch (e) {
      // Handle error
    }
  }

  void _listenToPlayerState() {
    // Watch current track
    ref.listen(playerStateProvider.select((s) => s.currentTrack), (previous, next) {
      _onTrackChanged(next);
    });

    // Watch playback state
    ref.listen(playerStateProvider.select((s) => s.isPlaying), (previous, isPlaying) {
      _onPlaybackStateChanged(isPlaying);
    });
  }

  /// 记录当前曲目播放
  Future<void> recordCurrentPlay({int? duration, bool? isComplete}) async {
    final playerState = ref.read(playerStateProvider);
    final track = playerState.currentTrack;
    if (track == null) return;

    final actualDuration =
        duration ?? playerState.position ~/ 1000;
    final actualIsComplete =
        isComplete ?? _isCompletePlay(track, actualDuration);

    await _serviceImpl.recordPlay(
      track,
      duration: actualDuration,
      isComplete: actualIsComplete,
    );
    
    // Refresh stats after recording
    await loadStats();
  }

  /// 轨道变化处理
  void _onTrackChanged(TrackModel? track) {
    if (track == null) {
      state = state.copyWith(currentTrackStats: null);
      return;
    }
    
    _loadTrackStats(track);
  }

  /// 播放状态变化处理
  void _onPlaybackStateChanged(bool isPlaying) {
    if (!isPlaying && state.autoRecordPlays) {
      recordCurrentPlay();
    }
  }

  /// 加载轨道统计
  Future<void> _loadTrackStats(TrackModel track) async {
    final stats = await _serviceImpl.getTrackStats(track);
    state = state.copyWith(currentTrackStats: stats);
  }

  Future<PlayStatsModel?> getTrackStats(TrackModel track) async {
    return await _serviceImpl.getTrackStats(track);
  }

  bool _isCompletePlay(TrackModel track, int durationSeconds) {
    final trackDuration = track.durationMs ~/ 1000;
    if (trackDuration <= 0) return false;
    return (durationSeconds / trackDuration) >= state.completePlayThreshold;
  }

  /// 切换自动记录播放
  void toggleAutoRecordPlays() {
    state = state.copyWith(autoRecordPlays: !state.autoRecordPlays);
  }

  /// 设置完整播放阈值
  void setCompletePlayThreshold(double threshold) {
    if (threshold >= 0.0 && threshold <= 1.0) {
      state = state.copyWith(completePlayThreshold: threshold);
    }
  }
}
