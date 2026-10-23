import 'package:audio_service/audio_service.dart' hide PlaybackState;
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';

class PyroAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  late final PlayerService _playerService;
  late final Isar _isar;
  
  PyroAudioHandler() {
    final registry = ServiceRegistry();
    _playerService = registry.getService<PlayerService>('player_service')!;
    _isar = GetIt.instance<Isar>();
    _init();
  }

  void _init() {
    // 监听播放器状态并映射到 AudioService
    _playerService.playback.playbackStateStream.listen((state) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          state == PlaybackState.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: _mapProcessingState(state),
        playing: state == PlaybackState.playing,
      ));
    });

    _playerService.playback.positionStream.listen((pos) {
      playbackState.add(playbackState.value.copyWith(updatePosition: pos));
    });
    
    // 监听当前轨道变化
    _playerService.playback.currentTrackStream.listen((trackId) async {
      if (trackId == null) {
        mediaItem.add(null);
        return;
      }
      
      final track = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
      if (track != null) {
        mediaItem.add(MediaItem(
          id: track.trackId,
          album: track.albumName ?? '',
          title: track.name,
          artist: track.artistNames?.join(', ') ?? '',
          duration: Duration(milliseconds: track.durationMs),
          artUri: track.imageUrl != null ? Uri.parse(track.imageUrl!) : null,
        ));
      }
    });
  }

  AudioProcessingState _mapProcessingState(PlaybackState state) {
    switch (state) {
      case PlaybackState.none: return AudioProcessingState.idle;
      case PlaybackState.buffering: return AudioProcessingState.buffering;
      case PlaybackState.playing: return AudioProcessingState.ready;
      case PlaybackState.paused: return AudioProcessingState.ready;
      case PlaybackState.completed: return AudioProcessingState.completed;
      case PlaybackState.error: return AudioProcessingState.error;
    }
  }

  @override
  Future<void> play() {
    final trackId = _playerService.currentTrackId;
    if (trackId != null) {
      return _playerService.play(trackId: trackId);
    }
    return Future.value();
  }

  @override
  Future<void> pause() => _playerService.pause();

  @override
  Future<void> stop() => _playerService.stop();

  @override
  Future<void> seek(Duration position) => _playerService.seekTo(position);

  @override
  Future<void> skipToNext() => _playerService.next();

  @override
  Future<void> skipToPrevious() => _playerService.previous();
}
