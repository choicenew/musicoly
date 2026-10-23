import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import '../services/player_service_impl.dart';
import 'playback_provider.dart';

part 'player_state_provider.freezed.dart';

/// 播放器状态
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
    TrackModel? currentTrack,
    @Default(0) int position,
  }) = _PlayerState;
}

/// Provider for PlayerStateNotifier
final playerStateProvider =
    NotifierProvider<PlayerStateNotifier, PlayerState>(() {
  return PlayerStateNotifier();
});

/// 播放器状态提供者 - 管理播放器状态
class PlayerStateNotifier extends Notifier<PlayerState> {
  late final PlayerServiceImpl _playerService;

  @override
  PlayerState build() {
    final registry = ServiceRegistry();
    _playerService =
        registry.getService<PlayerService>('player_service') as PlayerServiceImpl;
    _initialize();

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

  Future<void> refreshCurrentTrack() async {
    if (state.currentTrackId != null) {
      await _updateCurrentTrack(state.currentTrackId);
    }
  }

  Future<void> _updateCurrentTrack(String? trackId) async {
    if (trackId == null) {
      state = state.copyWith(currentTrack: null, currentTrackId: null);
      return;
    }

    final trackInterface = await _playerService.getCurrentTrack();
    final track = trackInterface != null ? TrackModel.fromInterface(trackInterface) : null;
    state = state.copyWith(
      currentTrackId: trackId,
      currentTrack: track,
    );
  }

  Future<void> _initialize() async {
    try {
      await _playerService.initialize();

      final currentTrackId = await _playerService.getCurrentTrackId();
      final isPlaying = await _playerService.isPlaying();
      final trackInterface = await _playerService.getCurrentTrack();
      final track = trackInterface != null ? TrackModel.fromInterface(trackInterface) : null;
      final pos = await _playerService.getPosition();

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

  Future<void> play({
    required String trackId,
    String? sourceId,
    String? sourceName,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      await _playerService.play(
        trackId: trackId,
        sourceId: sourceId,
        sourceName: sourceName,
      );

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

  Future<void> next() async {
    try {
      state = state.copyWith(isLoading: true);
      await _playerService.next();
      final currentTrackId = await _playerService.getCurrentTrackId();
      final trackInterface = await _playerService.getCurrentTrack();
      final track = trackInterface != null ? TrackModel.fromInterface(trackInterface) : null;
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

  Future<void> previous() async {
    try {
      state = state.copyWith(isLoading: true);
      await _playerService.previous();
      final currentTrackId = await _playerService.getCurrentTrackId();
      final trackInterface = await _playerService.getCurrentTrack();
      final track = trackInterface != null ? TrackModel.fromInterface(trackInterface) : null;
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

  void clearError() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
    );
  }
}
