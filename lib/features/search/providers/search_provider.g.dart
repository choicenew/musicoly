// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for search state

@ProviderFor(SearchNotifier)
final searchProvider = SearchNotifierProvider._();

/// Notifier for search state
final class SearchNotifierProvider
    extends $NotifierProvider<SearchNotifier, SearchStateData> {
  /// Notifier for search state
  SearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchNotifierHash();

  @$internal
  @override
  SearchNotifier create() => SearchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchStateData>(value),
    );
  }
}

String _$searchNotifierHash() => r'22b343f7d4bc3837435bd391968a10b6ca8fc012';

/// Notifier for search state

abstract class _$SearchNotifier extends $Notifier<SearchStateData> {
  SearchStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SearchStateData, SearchStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchStateData, SearchStateData>,
              SearchStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
