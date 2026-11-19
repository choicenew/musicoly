import 'package:meta/meta.dart';

@immutable
class SleepTimerConfigEntity {
  final bool isActive;
  final Duration remaining;

  const SleepTimerConfigEntity({
    this.isActive = false,
    this.remaining = Duration.zero,
  });
}
