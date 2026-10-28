// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 音轨源提供者实现 - 使用 TrackSourceManager

@ProviderFor(TrackSourceNotifier)
final trackSourceProvider = TrackSourceNotifierProvider._();

/// 音轨源提供者实现 - 使用 TrackSourceManager
final class TrackSourceNotifierProvider
    extends $NotifierProvider<TrackSourceNotifier, TrackSourceState> {
  /// 音轨源提供者实现 - 使用 TrackSourceManager
  TrackSourceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackSourceNotifierHash();

  @$internal
  @override
  TrackSourceNotifier create() => TrackSourceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackSourceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackSourceState>(value),
    );
  }
}

String _$trackSourceNotifierHash() =>
    r'f2912b4f70ba3372de003fa03fea5a1f0c9f646a';

/// 音轨源提供者实现 - 使用 TrackSourceManager

abstract class _$TrackSourceNotifier extends $Notifier<TrackSourceState> {
  TrackSourceState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TrackSourceState, TrackSourceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrackSourceState, TrackSourceState>,
              TrackSourceState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
