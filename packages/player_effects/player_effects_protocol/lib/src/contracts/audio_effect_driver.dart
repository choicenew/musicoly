import '../entities/audio_effect_config.dart';

abstract class AudioEffectDriver {
  String get effectId;
  String get effectName;
  Future<void> applyConfig(AudioEffectConfigEntity config);
}
