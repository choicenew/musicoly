// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 语言提供者

@ProviderFor(LanguageNotifier)
final languageProvider = LanguageNotifierProvider._();

/// 语言提供者
final class LanguageNotifierProvider
    extends $NotifierProvider<LanguageNotifier, LanguageState> {
  /// 语言提供者
  LanguageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageNotifierHash();

  @$internal
  @override
  LanguageNotifier create() => LanguageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageState>(value),
    );
  }
}

String _$languageNotifierHash() => r'0d24558a1454661273b570a0cc8354c23a9571e5';

/// 语言提供者

abstract class _$LanguageNotifier extends $Notifier<LanguageState> {
  LanguageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LanguageState, LanguageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LanguageState, LanguageState>,
              LanguageState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
