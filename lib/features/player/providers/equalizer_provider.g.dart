// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equalizer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EqualizerNotifier)
final equalizerProvider = EqualizerNotifierProvider._();

final class EqualizerNotifierProvider
    extends $NotifierProvider<EqualizerNotifier, EqualizerState> {
  EqualizerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'equalizerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$equalizerNotifierHash();

  @$internal
  @override
  EqualizerNotifier create() => EqualizerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqualizerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EqualizerState>(value),
    );
  }
}

String _$equalizerNotifierHash() => r'0f71d4c89b87c6cd2c8501f39cd2fcab76045945';

abstract class _$EqualizerNotifier extends $Notifier<EqualizerState> {
  EqualizerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EqualizerState, EqualizerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EqualizerState, EqualizerState>,
              EqualizerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
