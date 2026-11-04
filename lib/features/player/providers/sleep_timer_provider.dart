import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

class SleepTimerState {
  final bool isActive;
  final Duration remainingTime;
  final bool stopAtEndOfTrack;
  final bool fadeOut;

  const SleepTimerState({
    this.isActive = false,
    this.remainingTime = Duration.zero,
    this.stopAtEndOfTrack = false,
    this.fadeOut = true,
  });

  SleepTimerState copyWith({
    bool? isActive,
    Duration? remainingTime,
    bool? stopAtEndOfTrack,
    bool? fadeOut,
  }) {
    return SleepTimerState(
      isActive: isActive ?? this.isActive,
      remainingTime: remainingTime ?? this.remainingTime,
      stopAtEndOfTrack: stopAtEndOfTrack ?? this.stopAtEndOfTrack,
      fadeOut: fadeOut ?? this.fadeOut,
    );
  }
}

class SleepTimerNotifier extends StateNotifier<SleepTimerState> {
  final Ref _ref;
  Timer? _timer;

  SleepTimerNotifier(this._ref) : super(const SleepTimerState());

  void startTimer(Duration duration, {bool stopAtEndOfTrack = false, bool fadeOut = true}) {
    cancelTimer();

    state = SleepTimerState(
      isActive: true,
      remainingTime: duration,
      stopAtEndOfTrack: stopAtEndOfTrack,
      fadeOut: fadeOut,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.remainingTime.inSeconds <= 1) {
        if (state.stopAtEndOfTrack) {
          // 标记在曲终停播，由播放器监听到歌末时暂停
          cancelTimer();
        } else {
          await _triggerStop();
        }
      } else {
        final newRemaining = state.remainingTime - const Duration(seconds: 1);
        
        // 最后 15 秒渐隐音量
        if (state.fadeOut && newRemaining.inSeconds <= 15) {
          final currentVol = _ref.read(playbackStateProvider).volume;
          final targetVol = (currentVol * (newRemaining.inSeconds / 15.0)).clamp(0.0, 1.0);
          _ref.read(playbackStateProvider.notifier).setVolume(targetVol);
        }

        state = state.copyWith(remainingTime: newRemaining);
      }
    });
  }

  Future<void> _triggerStop() async {
    cancelTimer();
    await _ref.read(playbackStateProvider.notifier).pause();
    state = const SleepTimerState();
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    state = const SleepTimerState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final sleepTimerProvider = StateNotifierProvider<SleepTimerNotifier, SleepTimerState>((ref) {
  return SleepTimerNotifier(ref);
});
