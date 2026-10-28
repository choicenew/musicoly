// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 动态主题状态 - 存储从封面提取的颜色

@ProviderFor(DynamicThemeNotifier)
final dynamicThemeProvider = DynamicThemeNotifierProvider._();

/// 动态主题状态 - 存储从封面提取的颜色
final class DynamicThemeNotifierProvider
    extends $NotifierProvider<DynamicThemeNotifier, Color?> {
  /// 动态主题状态 - 存储从封面提取的颜色
  DynamicThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dynamicThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dynamicThemeNotifierHash();

  @$internal
  @override
  DynamicThemeNotifier create() => DynamicThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color?>(value),
    );
  }
}

String _$dynamicThemeNotifierHash() =>
    r'f136a06855d71930e20004fac8de92e4ccaa0a8f';

/// 动态主题状态 - 存储从封面提取的颜色

abstract class _$DynamicThemeNotifier extends $Notifier<Color?> {
  Color? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Color?, Color?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Color?, Color?>,
              Color?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
