// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AlbumNotifier)
final albumProvider = AlbumNotifierProvider._();

final class AlbumNotifierProvider
    extends $NotifierProvider<AlbumNotifier, AlbumState> {
  AlbumNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'albumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$albumNotifierHash();

  @$internal
  @override
  AlbumNotifier create() => AlbumNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlbumState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlbumState>(value),
    );
  }
}

String _$albumNotifierHash() => r'f747f44cce638fd24931424472e6c2a692f18bf7';

abstract class _$AlbumNotifier extends $Notifier<AlbumState> {
  AlbumState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AlbumState, AlbumState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AlbumState, AlbumState>,
              AlbumState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
