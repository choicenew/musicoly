import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/services/base_service.dart';

/// Base mixin for all providers that manage a service
/// 
/// Provides common functionality for service management
mixin BaseProviderMixin<T extends BaseService> {
  /// The service instance
  T? _service;

  /// Initialize the provider with a service
  Future<void> initializeService(T service, void Function(AsyncValue<T?>) updateState) async {
    updateState(const AsyncValue.loading());
    try {
      _service = service;
      await _service!.initialize();
      updateState(AsyncValue.data(_service));
    } catch (e, stackTrace) {
      updateState(AsyncValue.error(e, stackTrace));
    }
  }

  /// Get the service instance
  T get service {
    final value = _service;
    if (value == null) {
      throw Exception('Service not initialized');
    }
    return value;
  }

  /// Check if the service is initialized
  bool get isInitialized => _service != null;
}

