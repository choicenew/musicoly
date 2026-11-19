import 'dart:async';
import 'package:audio_player_protocol/audio_player_protocol.dart';

class JustAudioDriverImpl implements AudioPlayerDriver {
  final _stateController = StreamController<PlaybackStateEntity>.broadcast();
  PlaybackStateEntity _currentState = const PlaybackStateEntity();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> playUrl(String url) async {
    _currentState = PlaybackStateEntity(
      status: PlaybackStatus.playing,
      position: Duration.zero,
      duration: const Duration(minutes: 3, seconds: 30),
      volume: _currentState.volume,
    );
    _stateController.add(_currentState);
  }

  @override
  Future<void> pause() async {
    _currentState = PlaybackStateEntity(
      status: PlaybackStatus.paused,
      position: _currentState.position,
      duration: _currentState.duration,
      volume: _currentState.volume,
    );
    _stateController.add(_currentState);
  }

  @override
  Future<void> resume() async {
    _currentState = PlaybackStateEntity(
      status: PlaybackStatus.playing,
      position: _currentState.position,
      duration: _currentState.duration,
      volume: _currentState.volume,
    );
    _stateController.add(_currentState);
  }

  @override
  Future<void> stop() async {
    _currentState = const PlaybackStateEntity(status: PlaybackStatus.stopped);
    _stateController.add(_currentState);
  }

  @override
  Future<void> seek(Duration position) async {
    _currentState = PlaybackStateEntity(
      status: _currentState.status,
      position: position,
      duration: _currentState.duration,
      volume: _currentState.volume,
    );
    _stateController.add(_currentState);
  }

  @override
  Future<void> setVolume(double volume) async {
    _currentState = PlaybackStateEntity(
      status: _currentState.status,
      position: _currentState.position,
      duration: _currentState.duration,
      volume: volume,
    );
    _stateController.add(_currentState);
  }

  @override
  Stream<PlaybackStateEntity> get playbackStateStream => _stateController.stream;

  @override
  Future<void> dispose() async {
    await _stateController.close();
  }
}
