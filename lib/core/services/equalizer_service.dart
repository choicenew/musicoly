import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'dart:async';

class EqualizerService extends BaseService {
  bool _isEnabled = false;
  final List<double> _bandLevels = List.filled(10, 0.0);
  
  final _enabledController = StreamController<bool>.broadcast();
  final _bandsController = StreamController<List<double>>.broadcast();

  Stream<bool> get enabledStream => _enabledController.stream;
  Stream<List<double>> get bandsStream => _bandsController.stream;
  
  bool get isEnabled => _isEnabled;
  List<double> get bandLevels => _bandLevels;

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
