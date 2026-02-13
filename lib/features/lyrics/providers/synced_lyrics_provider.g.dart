// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_lyrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncedLyricsNotifier)
final syncedLyricsProvider = SyncedLyricsNotifierProvider._();

final class SyncedLyricsNotifierProvider
    extends $NotifierProvider<SyncedLyricsNotifier, SyncedLyricsState> {
  SyncedLyricsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncedLyricsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncedLyricsNotifierHash();

  @$internal
  @override
  SyncedLyricsNotifier create() => SyncedLyricsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncedLyricsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncedLyricsState>(value),
    );
  }
}

String _$syncedLyricsNotifierHash() =>
    r'a80b3cfeadeefd19d028fd9b1ded254ee8c9817b';

abstract class _$SyncedLyricsNotifier extends $Notifier<SyncedLyricsState> {
  SyncedLyricsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SyncedLyricsState, SyncedLyricsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncedLyricsState, SyncedLyricsState>,
              SyncedLyricsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
