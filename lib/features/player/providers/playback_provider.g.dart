// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 播放控制状态提供者 - 管理播放控制状态

@ProviderFor(PlaybackStateNotifier)
final playbackStateProvider = PlaybackStateNotifierProvider._();

/// 播放控制状态提供者 - 管理播放控制状态
final class PlaybackStateNotifierProvider
    extends $NotifierProvider<PlaybackStateNotifier, PlaybackStateData> {
  /// 播放控制状态提供者 - 管理播放控制状态
  PlaybackStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackStateNotifierHash();

  @$internal
  @override
  PlaybackStateNotifier create() => PlaybackStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaybackStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaybackStateData>(value),
    );
  }
}

String _$playbackStateNotifierHash() =>
    r'249e3a12f2fb93fc8d98b3bbda4e1676a6ae1e9f';

/// 播放控制状态提供者 - 管理播放控制状态

abstract class _$PlaybackStateNotifier extends $Notifier<PlaybackStateData> {
  PlaybackStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlaybackStateData, PlaybackStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaybackStateData, PlaybackStateData>,
              PlaybackStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
