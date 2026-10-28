import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/features/player/services/player_service.dart';
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
  late final PlayerService _playerService;
  final List<StreamSubscription> _subscriptions = [];

  @override
  PlaybackStateData build() {
    final registry = ServiceRegistry();
    _playerService =
        registry.getService<PlayerService>('player_service')!;

    _initialize();

    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });

    return const PlaybackStateData();
  }

  void _initialize() {
    _subscriptions.add(_playerService.playback.positionStream.listen((position) {
      state = state.copyWith(position: position);
    }));

    _subscriptions
        .add(_playerService.playback.bufferedPositionStream.listen((position) {
      state = state.copyWith(bufferedPosition: position);
    }));

    _subscriptions.add(_playerService.playback.durationStream.listen((duration) {
      state = state.copyWith(duration: duration);
    }));

    _subscriptions
        .add(_playerService.playback.playbackStateStream.listen((playbackState) {
      state = state.copyWith(playbackState: playbackState);
    }));

    _subscriptions.add(_playerService.playback.currentTrackStream.listen((trackId) {
      state = state.copyWith(currentTrackId: trackId);
    }));

    _subscriptions.add(_playerService.playback.volumeStream.listen((volume) {
      state = state.copyWith(volume: volume);
    }));
  }

  Future<void> playTrack(String trackId) async {
    await _playerService.play(trackId: trackId);
  }

  Future<void> playTracks(List<String> trackIds, {int initialIndex = 0}) async {
    if (trackIds.isEmpty) return;
    await _playerService.replaceQueue(trackIds, startIndex: initialIndex);
    final trackId = initialIndex < trackIds.length ? trackIds[initialIndex] : trackIds.first;
    await _playerService.play(trackId: trackId);
  }

  Future<void> shufflePlay(List<String> trackIds) async {
    if (trackIds.isEmpty) return;
    final shuffledIds = List<String>.from(trackIds)..shuffle();
    await playTracks(shuffledIds);
  }

  Future<void> pause() async {
    await _playerService.pause();
  }

  Future<void> resume() async {
    await _playerService.resume();
  }

  Future<void> stop() async {
    await _playerService.stop();
  }

  Future<void> next() async {
    await _playerService.next();
  }

  Future<void> previous() async {
    await _playerService.previous();
  }

  Future<void> seekTo(Duration position) async {
    await _playerService.seekTo(position);
  }

  Future<void> setVolume(double volume) async {
    await _playerService.setVolume(volume);
  }

  Future<void> setRepeatMode(RepeatMode mode) async {
    await _playerService.setRepeatMode(mode);
  }

  Future<void> setShuffleMode(bool enabled) async {
    await _playerService.setShuffleMode(enabled);
  }

  Future<void> toggleShuffle() async {
    await _playerService.setShuffleMode(!state.shuffleMode);
  }

  Future<void> toggleRepeatMode() async {
    final nextMode = switch (state.repeatMode) {
      RepeatMode.off => RepeatMode.all,
      RepeatMode.all => RepeatMode.one,
      RepeatMode.one => RepeatMode.off,
    };
    await _playerService.setRepeatMode(nextMode);
  }
}
