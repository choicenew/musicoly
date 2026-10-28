// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_lyric_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncedLyricNotifier)
final syncedLyricProvider = SyncedLyricNotifierProvider._();

final class SyncedLyricNotifierProvider
    extends $NotifierProvider<SyncedLyricNotifier, SyncedLyricState> {
  SyncedLyricNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncedLyricProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncedLyricNotifierHash();

  @$internal
  @override
  SyncedLyricNotifier create() => SyncedLyricNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncedLyricState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncedLyricState>(value),
    );
  }
}

String _$syncedLyricNotifierHash() =>
    r'df7b96c26a0334d106be85a60520b2982b18de8d';

abstract class _$SyncedLyricNotifier extends $Notifier<SyncedLyricState> {
  SyncedLyricState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SyncedLyricState, SyncedLyricState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncedLyricState, SyncedLyricState>,
              SyncedLyricState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
