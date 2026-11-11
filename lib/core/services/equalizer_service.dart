import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'dart:async';

/// 预设均衡器枚举
enum EqualizerPreset {
  flat('Flat', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
  pop('Pop', [-1, 1, 3, 4, 3, 0, -1, -2, -1, -1]),
  rock('Rock', [4, 3, 2, 0, -1, -1, 1, 2, 3, 4]),
  bassBoost('Bass Boost', [6, 5, 4, 2, 0, 0, 0, 0, 0, 0]),
  vocalBoost('Vocal Boost', [-2, -2, 0, 3, 5, 4, 2, 0, -1, -2]),
  classical('Classical', [4, 3, 2, 2, -1, -1, 0, 2, 3, 3]),
  electronic('Electronic', [4, 3, 0, -2, 2, 1, 0, 2, 4, 4]),
  jazz('Jazz', [3, 2, 0, 2, -1, -1, 0, 1, 2, 3]);

  final String name;
  final List<double> levels;
  const EqualizerPreset(this.name, this.levels);
}

enum ReverbPreset {
  none('None'),
  smallRoom('Small Room'),
  largeHall('Large Hall'),
  concertHall('Concert Hall'),
  stadium('Stadium');

  final String label;
  const ReverbPreset(this.label);
}

class EqualizerService extends BaseService {
  bool _isEnabled = false;
  List<double> _bandLevels = List.filled(10, 0.0);
  EqualizerPreset _currentPreset = EqualizerPreset.flat;
  double _bassBoost = 0.0;
  double _playbackSpeed = 1.0;
  double _pitchShift = 1.0;
  ReverbPreset _reverbPreset = ReverbPreset.none;

  final _enabledController = StreamController<bool>.broadcast();
  final _bandsController = StreamController<List<double>>.broadcast();

  Stream<bool> get enabledStream => _enabledController.stream;
  Stream<List<double>> get bandsStream => _bandsController.stream;

  bool get isEnabled => _isEnabled;
  List<double> get bandLevels => _bandLevels;
  EqualizerPreset get currentPreset => _currentPreset;
  double get bassBoost => _bassBoost;
  double get playbackSpeed => _playbackSpeed;
  double get pitchShift => _pitchShift;
  ReverbPreset get reverbPreset => _reverbPreset;

  @override
  String get serviceId => 'equalizer_service';

  @override
  String get serviceName => 'Equalizer Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  Future<void> setEnabled(bool enabled) async {
    _isEnabled = enabled;
    _enabledController.add(enabled);
    debugPrint('Equalizer enabled: $enabled');
  }

  Future<void> applyPreset(EqualizerPreset preset) async {
    _currentPreset = preset;
    _bandLevels = List<double>.from(preset.levels);
    _bandsController.add(List.from(_bandLevels));
    debugPrint('Equalizer preset applied: ${preset.name}');
  }

  Future<void> setBassBoost(double boost) async {
    _bassBoost = boost.clamp(0.0, 1.0);
    debugPrint('Bass boost set: $_bassBoost');
  }

  Future<void> setPlaybackSpeed(double speed) async {
    _playbackSpeed = speed.clamp(0.5, 2.0);
    debugPrint('Playback speed set: $_playbackSpeed');
  }

  Future<void> setPitchShift(double pitch) async {
    _pitchShift = pitch.clamp(0.5, 2.0);
    debugPrint('Pitch shift set: $_pitchShift');
  }

  Future<void> setReverbPreset(ReverbPreset reverb) async {
    _reverbPreset = reverb;
    debugPrint('Reverb preset set: ${reverb.label}');
  }

  Future<void> setBandLevel(int band, double level) async {
    if (band >= 0 && band < _bandLevels.length) {
      _bandLevels[band] = level;
      _bandsController.add(List.from(_bandLevels));
      debugPrint('Equalizer band $band level: $level');
    }
  }


  @override
  Future<void> dispose() async {
    await _enabledController.close();
    await _bandsController.close();
    await super.dispose();
  }
}

