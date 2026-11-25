import 'package:flutter/foundation.dart';

@immutable
class AudioEffectConfigEntity {
  final bool isEnabled;
  final double bassBoost;
  final double playbackSpeed;
  final double pitchShift;
  final String reverbPreset;

  const AudioEffectConfigEntity({
    this.isEnabled = false,
    this.bassBoost = 0.0,
    this.playbackSpeed = 1.0,
    this.pitchShift = 1.0,
    this.reverbPreset = 'None',
  });
}
