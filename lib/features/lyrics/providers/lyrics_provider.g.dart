// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 歌词提供者实现

@ProviderFor(LyricsNotifier)
final lyricsProvider = LyricsNotifierProvider._();

/// 歌词提供者实现
final class LyricsNotifierProvider
    extends $NotifierProvider<LyricsNotifier, LyricsState> {
  /// 歌词提供者实现
  LyricsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricsNotifierHash();

  @$internal
  @override
  LyricsNotifier create() => LyricsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LyricsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LyricsState>(value),
    );
  }
}

String _$lyricsNotifierHash() => r'af5dc80652ca1012ba1a275feb59145ba0630841';

/// 歌词提供者实现

abstract class _$LyricsNotifier extends $Notifier<LyricsState> {
  LyricsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LyricsState, LyricsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LyricsState, LyricsState>,
              LyricsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
