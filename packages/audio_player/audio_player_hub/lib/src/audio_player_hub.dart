import 'dart:async';
import 'package:audio_player_protocol/audio_player_protocol.dart';

class AudioPlayerHub {
  static final AudioPlayerHub _instance = AudioPlayerHub._internal();
  factory AudioPlayerHub() => _instance;
  AudioPlayerHub._internal();

  AudioPlayerDriver? _playerDriver;
  SystemMediaDriver? _systemMediaDriver;

  QueueEntity _queue = const QueueEntity();
  PlaybackStateEntity _state = const PlaybackStateEntity();
  EqualizerConfigEntity _equalizer = const EqualizerConfigEntity();
  SleepTimerConfigEntity _sleepTimer = const SleepTimerConfigEntity();

  Timer? _sleepTimerCountdown;
  bool _shuffleMode = false;
  int _repeatMode = 0; // 0: off, 1: all, 2: one

  void registerPlayerDriver(AudioPlayerDriver driver) {
    _playerDriver = driver;
    _playerDriver?.playbackStateStream.listen((state) {
      _state = state;
    });
  }

  void registerSystemMediaDriver(SystemMediaDriver driver) {
    _systemMediaDriver = driver;
  }

  PlaybackStateEntity get currentState => _state;
  QueueEntity get currentQueue => _queue;
  EqualizerConfigEntity get currentEqualizer => _equalizer;
  SleepTimerConfigEntity get currentSleepTimer => _sleepTimer;
  bool get shuffleMode => _shuffleMode;
  int get repeatMode => _repeatMode;

  Future<void> setQueue(List<String> trackIds, {int initialIndex = 0}) async {
    _queue = QueueEntity(trackIds: trackIds, currentIndex: initialIndex);
  }

  Future<void> playTrack(String audioUrl, {String? title, String? artist}) async {
    if (_playerDriver != null) {
      await _playerDriver!.playUrl(audioUrl);
      if (_systemMediaDriver != null && title != null && artist != null) {
        await _systemMediaDriver!.updateMetadata(title: title, artist: artist);
      }
    }
  }

  Future<void> pause() async => await _playerDriver?.pause();
  Future<void> resume() async => await _playerDriver?.resume();
  Future<void> stop() async => await _playerDriver?.stop();
  Future<void> seek(Duration position) async => await _playerDriver?.seek(position);

  void toggleShuffle() {
    _shuffleMode = !_shuffleMode;
  }

  void cycleRepeatMode() {
    _repeatMode = (_repeatMode + 1) % 3;
  }

  void setSleepTimer(Duration duration) {
    _sleepTimerCountdown?.cancel();
    _sleepTimer = SleepTimerConfigEntity(isActive: true, remaining: duration);
    _sleepTimerCountdown = Timer(duration, () {
      stop();
      _sleepTimer = const SleepTimerConfigEntity(isActive: false);
    });
  }

  void cancelSleepTimer() {
    _sleepTimerCountdown?.cancel();
    _sleepTimer = const SleepTimerConfigEntity(isActive: false);
  }
}
