// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 艺术家统计提供者实现

@ProviderFor(ArtistStatsNotifier)
final artistStatsProvider = ArtistStatsNotifierProvider._();

/// 艺术家统计提供者实现
final class ArtistStatsNotifierProvider
    extends $NotifierProvider<ArtistStatsNotifier, ArtistStatsState> {
  /// 艺术家统计提供者实现
  ArtistStatsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artistStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artistStatsNotifierHash();

  @$internal
  @override
  ArtistStatsNotifier create() => ArtistStatsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArtistStatsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArtistStatsState>(value),
    );
  }
}

String _$artistStatsNotifierHash() =>
    r'2a7da31fa799d4d70339303d9ac440c0055b83f7';

/// 艺术家统计提供者实现

abstract class _$ArtistStatsNotifier extends $Notifier<ArtistStatsState> {
  ArtistStatsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ArtistStatsState, ArtistStatsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArtistStatsState, ArtistStatsState>,
              ArtistStatsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
