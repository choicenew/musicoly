// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 播放器状态提供者 - 管理播放器状态

@ProviderFor(PlayerStateNotifier)
final playerStateProvider = PlayerStateNotifierProvider._();

/// 播放器状态提供者 - 管理播放器状态
final class PlayerStateNotifierProvider
    extends $NotifierProvider<PlayerStateNotifier, PlayerState> {
  /// 播放器状态提供者 - 管理播放器状态
  PlayerStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerStateNotifierHash();

  @$internal
  @override
  PlayerStateNotifier create() => PlayerStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerState>(value),
    );
  }
}

String _$playerStateNotifierHash() =>
    r'2bf7b2424ad43e98e981ef93adaaa682aaf8d690';

/// 播放器状态提供者 - 管理播放器状态

abstract class _$PlayerStateNotifier extends $Notifier<PlayerState> {
  PlayerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlayerState, PlayerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerState, PlayerState>,
              PlayerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
