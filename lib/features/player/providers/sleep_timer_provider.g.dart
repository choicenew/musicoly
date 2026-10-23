// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SleepTimerNotifier)
final sleepTimerProvider = SleepTimerNotifierProvider._();

final class SleepTimerNotifierProvider
    extends $NotifierProvider<SleepTimerNotifier, Duration?> {
  SleepTimerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepTimerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepTimerNotifierHash();

  @$internal
  @override
  SleepTimerNotifier create() => SleepTimerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration?>(value),
    );
  }
}

String _$sleepTimerNotifierHash() =>
    r'0db54dd4eace8498484313b12157c9bc9a0e80c7';

abstract class _$SleepTimerNotifier extends $Notifier<Duration?> {
  Duration? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Duration?, Duration?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Duration?, Duration?>,
              Duration?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
