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

String _$userPreferencesHash() => r'6a79dea15ae3e9a2d1b1802ca71fe4c2b5465019';

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
