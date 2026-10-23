import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';

import '../../../core/base/interfaces/player/player_interface.dart';
import '../services/player_service_impl.dart';

/// 播放器状态 - 存储播放器的当前状态
class PlayerState {
  /// 当前曲目ID
  final String? currentTrackId;

  /// 当前播放源ID（专辑/播放列表）
  final String? sourceId;

  /// 当前播放源名称
  final String? sourceName;

  /// 是否正在播放
  final bool isPlaying;

  /// 是否已准备好播放
  final bool isReady;

  /// 是否正在加载
  final bool isLoading;

  /// 是否发生错误
  final bool hasError;

  /// 错误信息
  final String? errorMessage;

  /// 构造函数
  const PlayerState({
    this.currentTrackId,
    this.sourceId,
    this.sourceName,
    this.isPlaying = false,
    this.isReady = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  /// 复制并更新状态
  PlayerState copyWith({
    String? currentTrackId,
    String? sourceId,
    String? sourceName,
    bool? isPlaying,
    bool? isReady,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return PlayerState(
      currentTrackId: currentTrackId ?? this.currentTrackId,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      isPlaying: isPlaying ?? this.isPlaying,
      isReady: isReady ?? this.isReady,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'PlayerState(currentTrackId: $currentTrackId, sourceId: $sourceId, '
        'sourceName: $sourceName, isPlaying: $isPlaying, isReady: $isReady, '
        'isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
  }
}

/// 播放器状态提供者 - 管理播放器状态
class PlayerStateNotifier extends StateNotifier<PlayerState> {
  /// 播放器服务
  final PlayerServiceImpl _playerService;

  /// Current track being played
  final ValueNotifier<TrackInterface?> currentTrack = ValueNotifier(null);

  /// Current playback position in milliseconds
  final ValueNotifier<int> position = ValueNotifier(0);

  /// Current playback state
  final ValueNotifier<PlayerState> playbackState =
      ValueNotifier(const PlayerState());

  /// 构造函数
  PlayerStateNotifier(this._playerService) : super(const PlayerState()) {
    _initialize();
  }

  /// 初始化
  Future<void> _initialize() async {
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
    );

    // 更新ValueNotifier状态
    currentTrack.value = track;
    position.value = pos.inMilliseconds;
    playbackState.value = state;
  }

  /// 播放曲目
  Future<void> play(
      {required String trackId, String? sourceId, String? sourceName}) async {
    try {
      // 更新状态为加载中
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );
      playbackState.value = state;

      // 播放曲目
      await _playerService.play(
        trackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
      );

      // 更新状态
      state = state.copyWith(
        currentTrackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
        isPlaying: true,
        isLoading: false,
      );
      playbackState.value = state;
    } catch (e) {
      // 更新错误状态
      state = state.copyWith(
        isPlaying: false,
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
    }
  }

  /// 暂停播放
  Future<void> pause() async {
    try {
      await _playerService.pause();
      state = state.copyWith(isPlaying: false);
      playbackState.value = state;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
    }
  }

  /// 恢复播放
  Future<void> resume() async {
    try {
      await _playerService.resume();
      state = state.copyWith(isPlaying: true);
      playbackState.value = state;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
    }
  }

  /// 停止播放
  Future<void> stop() async {
    try {
      await _playerService.stop();
      state = state.copyWith(
        isPlaying: false,
        currentTrackId: null,
        sourceId: null,
        sourceName: null,
      );
      playbackState.value = state;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
    }
  }

  /// 下一曲
  Future<void> next() async {
    try {
      state = state.copyWith(isLoading: true);
      playbackState.value = state;
      await _playerService.next();
      final currentTrackId = await _playerService.getCurrentTrackId();
      state = state.copyWith(
        currentTrackId: currentTrackId,
        isPlaying: true,
        isLoading: false,
      );
      playbackState.value = state;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
    }
  }

  /// 上一曲
  Future<void> previous() async {
    try {
      state = state.copyWith(isLoading: true);
      playbackState.value = state;
      await _playerService.previous();
      final currentTrackId = await _playerService.getCurrentTrackId();
      state = state.copyWith(
        currentTrackId: currentTrackId,
        isPlaying: true,
        isLoading: false,
      );
      playbackState.value = state;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      playbackState.value = state;
      rethrow;
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
      playbackState.value = state;
      rethrow;
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
      playbackState.value = state;
      rethrow;
    }
  }

  /// 清除错误状态
  void clearError() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
    );
    playbackState.value = state;
  }
}

/// 播放器状态提供者类型别名
typedef PlayerStateProvider
    = StateNotifierProvider<PlayerStateNotifier, PlayerState>;

/// 播放器状态提供者
final playerStateProvider = PlayerStateProvider((ref) {
  final playerService = PlayerServiceImpl();
  return PlayerStateNotifier(playerService);
});
