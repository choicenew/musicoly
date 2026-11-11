import 'package:flutter/foundation.dart';

/// Gapless Crossfade Engine (1s - 12s Track Transition Crossfade)
class CrossfadePlaybackEngine {
  bool _isCrossfadeEnabled = true;
  int _crossfadeDurationSeconds = 3;

  bool get isCrossfadeEnabled => _isCrossfadeEnabled;
  int get crossfadeDurationSeconds => _crossfadeDurationSeconds;

  void toggleCrossfade(bool enabled) {
    _isCrossfadeEnabled = enabled;
    debugPrint('Crossfade enabled: $_isCrossfadeEnabled');
  }

  void setDuration(int seconds) {
    _crossfadeDurationSeconds = seconds.clamp(1, 12);
    debugPrint('Crossfade duration set to: $_crossfadeDurationSeconds seconds');
  }
}
