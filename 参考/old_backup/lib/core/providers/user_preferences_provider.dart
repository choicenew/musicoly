import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

part 'user_preferences_provider.freezed.dart';
part 'user_preferences_provider.g.dart';

@freezed
class UserPreferencesState with _$UserPreferencesState {
  const factory UserPreferencesState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool amoledDark,
    @Default(true) bool albumColorSync,
    @Default(0xFF2196F3) int accentColorValue, // Store as int
    String? timeZone,
    @Default(false) bool use24HourFormat,
    @Default('high') String audioQuality,
    @Default(true) bool volumeNormalization,
    @Default(false) bool skipSilence,
    @Default(0) int crossfadeDuration,
    String? localeCode,
  }) = _UserPreferencesState;

  const UserPreferencesState._();

  Color get accentColor => Color(accentColorValue);
  Locale? get locale => localeCode != null
      ? Locale(localeCode!.split('_')[0],
          localeCode!.split('_').length > 1 ? localeCode!.split('_')[1] : null)
      : null;
}

@Riverpod(keepAlive: true)
class UserPreferences extends _$UserPreferences {
  @override
  Future<UserPreferencesState> build() async {
    final prefs = await SharedPreferences.getInstance();

    final themeModeIndex = prefs.getInt('themeMode') ?? 0;
    final amoledDark = prefs.getBool('amoledDark') ?? false;
    final albumColorSync = prefs.getBool('albumColorSync') ?? true;
    final accentColorValue = prefs.getInt('accentColor') ?? Colors.blue.value;
    final timeZone =
        prefs.getString('timeZone') ?? await FlutterTimezone.getLocalTimezone();
    final use24HourFormat = prefs.getBool('use24HourFormat') ?? false;
    final audioQuality = prefs.getString('audioQuality') ?? 'high';
    final volumeNormalization = prefs.getBool('volumeNormalization') ?? true;
    final skipSilence = prefs.getBool('skipSilence') ?? false;
    final crossfadeDuration = prefs.getInt('crossfadeDuration') ?? 0;
    final localeCode = prefs.getString('locale');

    return UserPreferencesState(
      themeMode: ThemeMode.values[themeModeIndex],
      amoledDark: amoledDark,
      albumColorSync: albumColorSync,
      accentColorValue: accentColorValue,
      timeZone: timeZone,
      use24HourFormat: use24HourFormat,
      audioQuality: audioQuality,
      volumeNormalization: volumeNormalization,
      skipSilence: skipSilence,
      crossfadeDuration: crossfadeDuration,
      localeCode: localeCode,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    state = AsyncData(state.value!.copyWith(themeMode: mode));
  }

  Future<void> setAmoledDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('amoledDark', value);
    state = AsyncData(state.value!.copyWith(amoledDark: value));
  }

  Future<void> setAlbumColorSync(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('albumColorSync', value);
    state = AsyncData(state.value!.copyWith(albumColorSync: value));
  }

  Future<void> setAccentColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentColor', color.value);
    state = AsyncData(state.value!.copyWith(accentColorValue: color.value));
  }

  Future<void> setTimeZone(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timeZone', value);
    state = AsyncData(state.value!.copyWith(timeZone: value));
  }

  Future<void> setUse24HourFormat(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use24HourFormat', value);
    state = AsyncData(state.value!.copyWith(use24HourFormat: value));
  }

  Future<void> setAudioQuality(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('audioQuality', value);
    state = AsyncData(state.value!.copyWith(audioQuality: value));
  }

  Future<void> setVolumeNormalization(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('volumeNormalization', value);
    state = AsyncData(state.value!.copyWith(volumeNormalization: value));
  }

  Future<void> setSkipSilence(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipSilence', value);
    state = AsyncData(state.value!.copyWith(skipSilence: value));
  }

  Future<void> setCrossfadeDuration(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('crossfadeDuration', value);
    state = AsyncData(state.value!.copyWith(crossfadeDuration: value));
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.toString());
    state = AsyncData(state.value!.copyWith(localeCode: locale.toString()));
  }
}
