import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/base/interfaces/player/player_interface.dart';
import '../../../core/base/interfaces/player/playback_interface.dart';
import '../../../core/base/services/player_service.dart';
import '../../../core/services/service_registry.dart';
import '../services/player_service_impl.dart';
import 'playback_provider.dart';

part 'player_state_provider.freezed.dart';
part 'player_state_provider.g.dart';

/// 播放器状态 - 存储播放器的当前状态
@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    String? currentTrackId,
    String? sourceId,
    String? sourceName,
    @Default(false) bool isPlaying,
    @Default(false) bool isReady,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    TrackInterface? currentTrack,
    @Default(0) int position,
  }) = _PlayerState;
}

/// 播放器状态提供者 - 管理播放器状态
@Riverpod(keepAlive: true)
class PlayerStateNotifier extends _$PlayerStateNotifier {
  /// 播放器服务
  late final PlayerServiceImpl _playerService;

  @override
  PlayerState build() {
    final registry = ServiceRegistry();
    _playerService = registry.getService<PlayerService>('player_service') as PlayerServiceImpl;
    _initialize();

    // 监听播放控制状态
    ref.listen(playbackStateProvider, (previous, next) {
      if (next.currentTrackId != state.currentTrackId) {
        _updateCurrentTrack(next.currentTrackId);
      }
      
      state = state.copyWith(
        position: next.position.inMilliseconds,
        isPlaying: next.playbackState == PlaybackState.playing,
        isLoading: next.playbackState == PlaybackState.buffering,
      );
    });

    return const PlayerState();
  }

  /// 刷新当前曲目信息
  Future<void> refreshCurrentTrack() async {
    if (state.currentTrackId != null) {
      await _updateCurrentTrack(state.currentTrackId);
    }
  }

  /// 更新当前曲目信息
  Future<void> _updateCurrentTrack(String? trackId) async {
    if (trackId == null) {
      state = state.copyWith(currentTrack: null, currentTrackId: null);
      return;
    }
    
    final track = await _playerService.getCurrentTrack();
    state = state.copyWith(
      currentTrackId: trackId,
      currentTrack: track,
    );
  }

  /// 初始化
  Future<void> _initialize() async {
    try {
      // 初始化播放器服务
      await _playerService.initialize();

      // 获取当前曲目ID和状态
      final currentTrackId = await _playerService.getCurrentTrackId();
      final isPlaying = await _playerService.isPlaying();
      final track = await _playerService.getCurrentTrack();
      final pos = await _playerService.getPosition();

      // 更新状态
      state = state.copyWith(
        currentTrackId: currentTrackId,
        isPlaying: isPlaying,
        isReady: true,
        currentTrack: track,
        position: pos.inMilliseconds,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 播放曲目
  Future<void> play({
    required String trackId,
    String? sourceId,
    String? sourceName,
  }) async {
    try {
      // 更新状态为加载中
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      // 播放曲目
      await _playerService.play(
        trackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
      );

      // 更新状态为正在播放
      state = state.copyWith(
        currentTrackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
        isPlaying: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 暂停
  Future<void> pause() async {
    try {
      await _playerService.pause();
      state = state.copyWith(isPlaying: false);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 恢复播放
  Future<void> resume() async {
    try {
      await _playerService.resume();
      state = state.copyWith(isPlaying: true);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 停止
  Future<void> stop() async {
    try {
      await _playerService.stop();
      state = state.copyWith(
        isPlaying: false,
        currentTrackId: null,
        sourceId: null,
        sourceName: null,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 下一曲
  Future<void> next() async {
    try {
      state = state.copyWith(isLoading: true);
      await _playerService.next();
      final currentTrackId = await _playerService.getCurrentTrackId();
      final track = await _playerService.getCurrentTrack();
      state = state.copyWith(
        currentTrackId: currentTrackId,
        currentTrack: track,
        isPlaying: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 上一曲
  Future<void> previous() async {
    try {
      state = state.copyWith(isLoading: true);
      await _playerService.previous();
      final currentTrackId = await _playerService.getCurrentTrackId();
      final track = await _playerService.getCurrentTrack();
      state = state.copyWith(
        currentTrackId: currentTrackId,
        currentTrack: track,
        isPlaying: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 跳转位置
  Future<void> seek(Duration position) async {
    try {
      await _playerService.seekTo(position);
      state = state.copyWith(position: position.inMilliseconds);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode) async {
    try {
      await _playerService.setRepeatMode(mode);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    try {
      await _playerService.setShuffleMode(enabled);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
    );
  }
}
