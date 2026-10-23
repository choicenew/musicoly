import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/features/player/services/playback_service_impl.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'playback_provider.freezed.dart';

/// 播放控制状态数据类
@freezed
abstract class PlaybackStateData with _$PlaybackStateData {
  const factory PlaybackStateData({
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,
    @Default(Duration.zero) Duration duration,
    @Default(PlaybackState.none) PlaybackState playbackState,
    @Default(1.0) double volume,
    @Default(RepeatMode.off) RepeatMode repeatMode,
    @Default(false) bool shuffleMode,
    String? currentTrackId,
  }) = _PlaybackStateData;
}

/// Provider for PlaybackStateNotifier
final playbackStateProvider =
    NotifierProvider<PlaybackStateNotifier, PlaybackStateData>(() {
  return PlaybackStateNotifier();
});

/// 播放控制状态提供者 - 管理播放控制状态
class PlaybackStateNotifier extends Notifier<PlaybackStateData> {
  late final PlaybackService _playbackService;
  final List<StreamSubscription> _subscriptions = [];

  @override
  PlaybackStateData build() {
    final registry = ServiceRegistry();
    _playbackService =
        registry.getService<PlaybackService>('playback_service')!;

    _initialize();

    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });

    return const PlaybackStateData();
  }

  void _initialize() {
    _subscriptions.add(_playbackService.positionStream.listen((position) {
      state = state.copyWith(position: position);
    }));

    _subscriptions
        .add(_playbackService.bufferedPositionStream.listen((position) {
      state = state.copyWith(bufferedPosition: position);
    }));

    _subscriptions.add(_playbackService.durationStream.listen((duration) {
      state = state.copyWith(duration: duration);
    }));

    _subscriptions
        .add(_playbackService.playbackStateStream.listen((playbackState) {
      state = state.copyWith(playbackState: playbackState);
    }));

    _subscriptions.add(_playbackService.currentTrackStream.listen((trackId) {
      state = state.copyWith(currentTrackId: trackId);
    }));

    _subscriptions.add(_playbackService.volumeStream.listen((volume) {
      state = state.copyWith(volume: volume);
    }));
  }

  Future<void> playTrack(String trackId) async {
    await _playbackService.playTrack(trackId);
  }

  Future<void> playTracks(List<String> trackIds, {int initialIndex = 0}) async {
    await _playbackService.playTracks(trackIds, initialIndex: initialIndex);
  }

  Future<void> shufflePlay(List<String> trackIds) async {
    if (trackIds.isEmpty) return;
    final shuffledIds = List<String>.from(trackIds)..shuffle();
    await _playbackService.playTracks(shuffledIds);
  }

  Future<void> pause() async {
    await _playbackService.pausePlayback();
  }

  Future<void> resume() async {
    await _playbackService.resumePlayback();
  }

  Future<void> stop() async {
    await _playbackService.stopPlayback();
  }

  Future<void> next() async {
    await _playbackService.skipToNext();
  }

  Future<void> previous() async {
    await _playbackService.skipToPrevious();
  }

  Future<void> seekTo(Duration position) async {
    await _playbackService.seekTo(position);
  }

  Future<void> setVolume(double volume) async {
    await _playbackService.setVolume(volume);
  }

  Future<void> setRepeatMode(RepeatMode mode) async {
    await _playbackService.setRepeatMode(mode);
  }

  Future<void> setShuffleMode(bool enabled) async {
    await _playbackService.setShuffleMode(enabled);
  }

  Future<void> toggleShuffle() async {
    await _playbackService.setShuffleMode(!state.shuffleMode);
  }

  Future<void> toggleRepeatMode() async {
    final nextMode = switch (state.repeatMode) {
      RepeatMode.off => RepeatMode.all,
      RepeatMode.all => RepeatMode.one,
      RepeatMode.one => RepeatMode.off,
    };
    await _playbackService.setRepeatMode(nextMode);
  }
}
