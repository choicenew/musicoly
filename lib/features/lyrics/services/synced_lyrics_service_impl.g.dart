// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_lyrics_service_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncedLyricsService)
final syncedLyricsServiceProvider = SyncedLyricsServiceProvider._();

final class SyncedLyricsServiceProvider
    extends
        $FunctionalProvider<
          SyncedLyricsServiceImpl,
          SyncedLyricsServiceImpl,
          SyncedLyricsServiceImpl
        >
    with $Provider<SyncedLyricsServiceImpl> {
  SyncedLyricsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncedLyricsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncedLyricsServiceHash();

  @$internal
  @override
  $ProviderElement<SyncedLyricsServiceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncedLyricsServiceImpl create(Ref ref) {
    return syncedLyricsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncedLyricsServiceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncedLyricsServiceImpl>(value),
    );
  }
}

String _$syncedLyricsServiceHash() =>
    r'0fc8ffdabb2eed20d533957eaf5b50010ba8c7b9';
