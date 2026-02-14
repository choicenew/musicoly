// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 歌词提供者实现

@ProviderFor(LyricNotifier)
final lyricProvider = LyricNotifierProvider._();

/// 歌词提供者实现
final class LyricNotifierProvider
    extends $NotifierProvider<LyricNotifier, LyricState> {
  /// 歌词提供者实现
  LyricNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lyricProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lyricNotifierHash();

  @$internal
  @override
  LyricNotifier create() => LyricNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LyricState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LyricState>(value),
    );
  }
}

String _$lyricNotifierHash() => r'bb2813b1d78418bd95cab99726e184b4881202b2';

/// 歌词提供者实现

abstract class _$LyricNotifier extends $Notifier<LyricState> {
  LyricState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LyricState, LyricState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LyricState, LyricState>,
              LyricState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
