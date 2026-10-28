import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/services/sleep_timer_service.dart';

part 'sleep_timer_provider.g.dart';

@riverpod
class SleepTimerNotifier extends _$SleepTimerNotifier {
  late final SleepTimerService _service;
  StreamSubscription? _subscription;

  @override
  Duration? build() {
    final registry = ServiceRegistry();
    _service = registry.getService<SleepTimerService>('sleep_timer')!;
    
    _subscription = _service.remainingTimeStream.listen((time) {
      state = time;
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return _service.remainingTime;
  }

  void start(Duration duration, {bool finishLastTrack = false}) {
    _service.start(duration, finishLastTrack: finishLastTrack);
  }

  void stop() {
    _service.stop();
  }
}
