// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_service_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lyricsService)
final lyricsServiceProvider = LyricsServiceProvider._();

final class LyricsServiceProvider
    extends $FunctionalProvider<LyricsService, LyricsService, LyricsService>
    with $Provider<LyricsService> {
  LyricsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricsServiceHash();

  @$internal
  @override
  $ProviderElement<LyricsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LyricsService create(Ref ref) {
    return lyricsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LyricsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LyricsService>(value),
    );
  }
}

String _$lyricsServiceHash() => r'8932dd27bb26974607ba3ebabd1ca511f49bc66f';
