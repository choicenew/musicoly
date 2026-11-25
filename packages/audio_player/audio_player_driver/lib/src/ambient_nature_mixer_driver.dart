import 'package:flutter/foundation.dart';

enum NatureSoundType {
  rain('Rain', '轻柔雨声'),
  ocean('Ocean Waves', '海浪波涛'),
  wind('Night Wind', '夜风轻拂'),
  forest('Forest Birds', '森林鸟鸣'),
  whiteNoise('White Noise', '舒适白噪音');

  final String id;
  final String label;
  const NatureSoundType(this.id, this.label);
}

/// Mucke & Natures-Music Inspired Ambient Sound Mixer Driver
class AmbientNatureMixerDriver {
  final Map<NatureSoundType, double> _soundVolumes = {
    for (var type in NatureSoundType.values) type: 0.0,
  };

  double getVolume(NatureSoundType type) => _soundVolumes[type] ?? 0.0;

  void setVolume(NatureSoundType type, double volume) {
    _soundVolumes[type] = volume.clamp(0.0, 1.0);
    debugPrint('Ambient nature sound ${type.label} volume set to: ${_soundVolumes[type]}');
  }

  void stopAll() {
    for (var type in NatureSoundType.values) {
      _soundVolumes[type] = 0.0;
    }
    debugPrint('All ambient nature sounds stopped');
  }
}
