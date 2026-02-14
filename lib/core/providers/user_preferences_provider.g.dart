// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPreferences)
final userPreferencesProvider = UserPreferencesProvider._();

final class UserPreferencesProvider
    extends $AsyncNotifierProvider<UserPreferences, UserPreferencesState> {
  UserPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesHash();

  @$internal
  @override
  UserPreferences create() => UserPreferences();
}

String _$userPreferencesHash() => r'894527a76e0badb318723531f37e24b5705b246d';

abstract class _$UserPreferences extends $AsyncNotifier<UserPreferencesState> {
  FutureOr<UserPreferencesState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<UserPreferencesState>, UserPreferencesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UserPreferencesState>,
                UserPreferencesState
              >,
              AsyncValue<UserPreferencesState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
