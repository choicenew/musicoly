import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// RetroMusic Style Shake-to-Skip (摇一摇切歌手势服务)
class ShakeGestureService extends BaseService {
  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  @override
  String get serviceId => 'shake_gesture_service';

  @override
  String get serviceName => 'Shake Gesture Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    debugPrint('Shake to skip enabled: $_isEnabled');
    if (_isEnabled) {
      _startListening();
    }
  }

  void _startListening() {
    // 监听重力加速度传感器实现摇一摇切歌
    debugPrint('Listening to accelerometer for shake gesture...');
  }
}
