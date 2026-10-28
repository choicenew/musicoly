import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/core/services/base_service.dart';

abstract class PlaybackInterface {
  Stream<Duration> get positionStream;
  Stream<Duration> get bufferedPositionStream;
  Stream<Duration> get durationStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<String?> get currentTrackStream;
  Stream<double> get volumeStream;
  Stream<RepeatMode> get repeatModeStream;
  Stream<bool> get shuffleModeStream;

  PlaybackState get currentState;
  double get volume;
  RepeatMode get repeatMode;
  bool get shuffleMode;
  Duration get duration;
  Duration get position;
}

abstract class PlayerService extends BaseService {
  PlaybackInterface get playback;
  String? get currentTrackId;
  Duration get position;
  Duration get bufferedPosition;
  Duration get duration;
  double get volume;
  PlaybackState get state;
  RepeatMode get repeatMode;
  bool get shuffleMode;

  Future<void> play({required String trackId, String? sourceId, String? sourceName});
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> seekTo(Duration position);
  Future<void> seek(Duration position);
  Future<void> next();
  Future<void> previous();
  Future<void> setVolume(double volume);
  Future<void> setPlaybackSpeed(double speed);
  Future<void> setRepeatMode(RepeatMode mode);
  Future<void> setShuffleMode(bool enabled);
  Future<Duration> getPosition();
  Future<Duration> getDuration();
  Future<bool> isPlaying();
  Future<String?> getCurrentTrackId();
  Future<TrackInterface?> getCurrentTrack();
  Future<List<String>> getAvailableDevices();
  Future<bool> transferPlayback(String deviceId);
  Future<void> addTrack(String trackId);
  Future<void> addTracks(List<String> trackIds);
  Future<void> addTracksNext(List<String> trackIds);
  Future<void> removeTrack(String trackId);
  Future<void> removeTrackAt(int index);
  Future<void> clearQueue();
  Future<List<String>> getQueue();
  Future<int> getCurrentIndex();
  Future<void> moveTrack(int oldIndex, int newIndex);
  Future<void> skipToIndex(int index);
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0});
  Future<List<String>> getHistory();
  Future<void> clearHistory();
}
