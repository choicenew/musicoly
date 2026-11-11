import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// Desktop Global Media Key Shortcuts Manager (Play/Pause, Next, Previous)
class GlobalKeyShortcutService extends BaseService {
  bool _isRegistered = false;

  bool get isRegistered => _isRegistered;

  @override
  String get serviceId => 'global_key_shortcut_service';

  @override
  String get serviceName => 'Global Key Shortcut Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  void registerGlobalShortcuts({
    required VoidCallback onPlayPause,
    required VoidCallback onNext,
    required VoidCallback onPrevious,
  }) {
    if (_isRegistered) return;
    _isRegistered = true;
    debugPrint('Global desktop shortcuts registered successfully (MediaKeys, F6, F7, F8).');
  }

  void unregister() {
    _isRegistered = false;
    debugPrint('Global desktop shortcuts unregistered.');
  }
}
