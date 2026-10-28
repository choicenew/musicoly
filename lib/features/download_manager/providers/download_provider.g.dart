// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 下载管理器提供者实现类

@ProviderFor(DownloadNotifier)
final downloadProvider = DownloadNotifierProvider._();

/// 下载管理器提供者实现类
final class DownloadNotifierProvider
    extends $NotifierProvider<DownloadNotifier, DownloadState> {
  /// 下载管理器提供者实现类
  DownloadNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadNotifierHash();

  @$internal
  @override
  DownloadNotifier create() => DownloadNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadState>(value),
    );
  }
}

String _$downloadNotifierHash() => r'3a0361ddceeb672c961aa15e0d4cf74b4f8c762a';

/// 下载管理器提供者实现类

abstract class _$DownloadNotifier extends $Notifier<DownloadState> {
  DownloadState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DownloadState, DownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DownloadState, DownloadState>,
              DownloadState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
