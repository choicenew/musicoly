// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_scanner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalScannerNotifier)
final localScannerProvider = LocalScannerNotifierProvider._();

final class LocalScannerNotifierProvider
    extends $NotifierProvider<LocalScannerNotifier, bool> {
  LocalScannerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localScannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localScannerNotifierHash();

  @$internal
  @override
  LocalScannerNotifier create() => LocalScannerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$localScannerNotifierHash() =>
    r'43f91679c0473b531ee789c20ecdea654b3db4e8';

abstract class _$LocalScannerNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
