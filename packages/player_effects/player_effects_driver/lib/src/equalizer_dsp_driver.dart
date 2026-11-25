import 'package:flutter/foundation.dart';
import 'package:player_effects_protocol/player_effects_protocol.dart';

class EqualizerDspDriver implements AudioEffectDriver {
  @override
  String get effectId => 'equalizer_dsp';

  @override
  String get effectName => '10-Band Equalizer DSP & Bass Boost Driver';

  @override
  Future<void> applyConfig(AudioEffectConfigEntity config) async {
    debugPrint('Applied DSP audio effect config: BassBoost=${config.bassBoost}, Speed=${config.playbackSpeed}');
  }
}
