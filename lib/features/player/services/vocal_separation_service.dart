import 'package:flutter/foundation.dart';

/// AI Vocal Separation & Karaoke Mode Stem Extractor Service
class VocalSeparationService {
  bool _isKaraokeModeEnabled = false;
  double _vocalVolume = 1.0;
  double _instrumentalVolume = 1.0;

  bool get isKaraokeModeEnabled => _isKaraokeModeEnabled;
  double get vocalVolume => _vocalVolume;
  double get instrumentalVolume => _instrumentalVolume;

  void toggleKaraokeMode(bool enabled) {
    _isKaraokeModeEnabled = enabled;
    debugPrint('AI Karaoke vocal separation enabled: $_isKaraokeModeEnabled');
  }

  void setVocalVolume(double volume) {
    _vocalVolume = volume.clamp(0.0, 1.0);
    debugPrint('Vocal volume set: $_vocalVolume');
  }

  void setInstrumentalVolume(double volume) {
    _instrumentalVolume = volume.clamp(0.0, 1.0);
    debugPrint('Instrumental volume set: $_instrumentalVolume');
  }
}
