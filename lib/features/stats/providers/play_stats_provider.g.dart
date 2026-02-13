// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 播放统计提供者实现

@ProviderFor(PlayStatsNotifier)
final playStatsProvider = PlayStatsNotifierProvider._();

/// 播放统计提供者实现
final class PlayStatsNotifierProvider
    extends $NotifierProvider<PlayStatsNotifier, PlayStatsState> {
  /// 播放统计提供者实现
  PlayStatsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playStatsNotifierHash();

  @$internal
  @override
  PlayStatsNotifier create() => PlayStatsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayStatsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayStatsState>(value),
    );
  }
}

String _$playStatsNotifierHash() => r'0ff6b8ae77c485a6e49fb8162520fdde081608d7';

/// 播放统计提供者实现

abstract class _$PlayStatsNotifier extends $Notifier<PlayStatsState> {
  PlayStatsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlayStatsState, PlayStatsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayStatsState, PlayStatsState>,
              PlayStatsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
