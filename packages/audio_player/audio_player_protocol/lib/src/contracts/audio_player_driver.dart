import '../entities/playback_state_entity.dart';

abstract class AudioPlayerDriver {
  Future<void> initialize();
  Future<void> playUrl(String url);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> setVolume(double volume);
  Stream<PlaybackStateEntity> get playbackStateStream;
  Future<void> dispose();
}
