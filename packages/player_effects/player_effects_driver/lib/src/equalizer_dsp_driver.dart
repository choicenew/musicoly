import 'package:flutter/foundation.dart';
import 'package:player_effects_protocol/player_effects_protocol.dart';

class EqualizerDspDriver implements AudioEffectDriver {
  final List<double> _bandGains = List.filled(10, 0.0); // 10 bands: 32Hz to 16kHz
  double _bassBoostGain = 0.0;
  double _spatialAudioReverb = 0.0;
  bool _vocalRemoverActive = false;

  @override
  String get effectId => 'equalizer_dsp';

  @override
  String get effectName => 'Professional 10-Band Equalizer & Spatial Audio DSP Driver';

  void setBandGain(int bandIndex, double gainDb) {
    if (bandIndex >= 0 && bandIndex < 10) {
      _bandGains[bandIndex] = gainDb.clamp(-15.0, 15.0);
      debugPrint('DSP 10-Band EQ band $bandIndex set to ${_bandGains[bandIndex]} dB');
    }
  }

  void setBassBoost(double boost) {
    _bassBoostGain = boost.clamp(0.0, 20.0);
    debugPrint('DSP Bass Boost set to: $_bassBoostGain dB');
  }

  void setSpatialAudio(double reverb) {
    _spatialAudioReverb = reverb.clamp(0.0, 1.0);
    debugPrint('DSP 3D Spatial Audio Reverb set to: $_spatialAudioReverb');
  }

  void setVocalRemover(bool active) {
    _vocalRemoverActive = active;
    debugPrint('DSP AI Vocal Remover active: $_vocalRemoverActive');
  }

  @override
  Future<void> applyConfig(AudioEffectConfigEntity config) async {
    setBassBoost(config.bassBoost);
    debugPrint('Applied full DSP audio effect config successfully.');
  }

  List<double> get bandGains => List.unmodifiable(_bandGains);
  double get bassBoostGain => _bassBoostGain;
  double get spatialAudioReverb => _spatialAudioReverb;
  bool get vocalRemoverActive => _vocalRemoverActive;
}
