// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 队列状态提供者 - 管理播放队列状态

@ProviderFor(QueueStateNotifier)
final queueStateProvider = QueueStateNotifierProvider._();

/// 队列状态提供者 - 管理播放队列状态
final class QueueStateNotifierProvider
    extends $NotifierProvider<QueueStateNotifier, QueueState> {
  /// 队列状态提供者 - 管理播放队列状态
  QueueStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queueStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queueStateNotifierHash();

  @$internal
  @override
  QueueStateNotifier create() => QueueStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QueueState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QueueState>(value),
    );
  }
}

String _$queueStateNotifierHash() =>
    r'b5e9902a36f7031c6d9d176d48bebff80308f4dc';

/// 队列状态提供者 - 管理播放队列状态

abstract class _$QueueStateNotifier extends $Notifier<QueueState> {
  QueueState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<QueueState, QueueState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QueueState, QueueState>,
              QueueState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
