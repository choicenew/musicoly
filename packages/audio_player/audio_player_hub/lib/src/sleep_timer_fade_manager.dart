import 'dart:async';
import 'package:flutter/foundation.dart';

/// Sleep Timer with Gradual Volume Fade-Out (InnerTune & Musify Inspired)
class SleepTimerFadeManager {
  Timer? _timer;
  Timer? _fadeTimer;

  void startSleepTimer({
    required Duration duration,
    required Future<void> Function() onComplete,
    required Future<void> Function(double volume) onVolumeFade,
  }) {
    cancelTimer();
    debugPrint('Sleep timer started for ${duration.inMinutes} minutes with volume fade-out.');

    // Timer before fade starts (duration minus 30 seconds fade)
    final fadeDelay = duration > const Duration(seconds: 30)
        ? duration - const Duration(seconds: 30)
        : Duration.zero;

    _timer = Timer(fadeDelay, () {
      // Start 30 seconds volume fade out
      double volume = 1.0;
      const steps = 30;
      final stepDuration = const Duration(seconds: 1);

      _fadeTimer = Timer.periodic(stepDuration, (timer) async {
        volume -= (1.0 / steps);
        if (volume <= 0.0) {
          volume = 0.0;
          timer.cancel();
          await onVolumeFade(0.0);
          await onComplete();
          debugPrint('Sleep timer completed and audio stopped with volume fade.');
        } else {
          await onVolumeFade(volume);
        }
      });
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _fadeTimer?.cancel();
    _timer = null;
    _fadeTimer = null;
  }
}
