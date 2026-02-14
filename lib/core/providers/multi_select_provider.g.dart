// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_select_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MultiSelectNotifier)
final multiSelectProvider = MultiSelectNotifierProvider._();

final class MultiSelectNotifierProvider
    extends $NotifierProvider<MultiSelectNotifier, Set<String>> {
  MultiSelectNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'multiSelectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$multiSelectNotifierHash();

  @$internal
  @override
  MultiSelectNotifier create() => MultiSelectNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$multiSelectNotifierHash() =>
    r'94e8434811993d9cfd21115827c54806421b7e27';

abstract class _$MultiSelectNotifier extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
