// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArtistNotifier)
final artistProvider = ArtistNotifierProvider._();

final class ArtistNotifierProvider
    extends $NotifierProvider<ArtistNotifier, ArtistState> {
  ArtistNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artistProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artistNotifierHash();

  @$internal
  @override
  ArtistNotifier create() => ArtistNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArtistState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArtistState>(value),
    );
  }
}

String _$artistNotifierHash() => r'7aa091adf93f95cae846bcd150ac1037a42046fa';

abstract class _$ArtistNotifier extends $Notifier<ArtistState> {
  ArtistState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ArtistState, ArtistState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArtistState, ArtistState>,
              ArtistState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
