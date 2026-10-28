// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrobbler_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Scrobbler 管理器 - 负责管理和分发播放记录到各个插件

@ProviderFor(scrobblerManager)
final scrobblerManagerProvider = ScrobblerManagerProvider._();

/// Scrobbler 管理器 - 负责管理和分发播放记录到各个插件

final class ScrobblerManagerProvider
    extends
        $FunctionalProvider<
          ScrobblerManager,
          ScrobblerManager,
          ScrobblerManager
        >
    with $Provider<ScrobblerManager> {
  /// Scrobbler 管理器 - 负责管理和分发播放记录到各个插件
  ScrobblerManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scrobblerManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scrobblerManagerHash();

  @$internal
  @override
  $ProviderElement<ScrobblerManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScrobblerManager create(Ref ref) {
    return scrobblerManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScrobblerManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScrobblerManager>(value),
    );
  }
}

String _$scrobblerManagerHash() => r'82146b14b2895958b83c7d7bcdb5e214b7f9651c';
