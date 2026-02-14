import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

part 'user_preferences_provider.freezed.dart';
part 'user_preferences_provider.g.dart';

@freezed
abstract class UserPreferencesState with _$UserPreferencesState {
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
    final accentColorValue = prefs.getInt('accentColor') ?? Colors.blue.toARGB32();
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
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('themeMode', mode.index);
      return state.requireValue.copyWith(themeMode: mode);
    });
  }

  Future<void> setAmoledDark(bool value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('amoledDark', value);
      return state.requireValue.copyWith(amoledDark: value);
    });
  }

  Future<void> setAlbumColorSync(bool value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('albumColorSync', value);
      return state.requireValue.copyWith(albumColorSync: value);
    });
  }

  Future<void> setAccentColor(Color color) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('accentColor', color.toARGB32());
      return state.requireValue.copyWith(accentColorValue: color.toARGB32());
    });
  }

  Future<void> setTimeZone(String value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('timeZone', value);
      return state.requireValue.copyWith(timeZone: value);
    });
  }

  Future<void> setUse24HourFormat(bool value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('use24HourFormat', value);
      return state.requireValue.copyWith(use24HourFormat: value);
    });
  }

  Future<void> setAudioQuality(String value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('audioQuality', value);
      return state.requireValue.copyWith(audioQuality: value);
    });
  }

  Future<void> setVolumeNormalization(bool value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('volumeNormalization', value);
      return state.requireValue.copyWith(volumeNormalization: value);
    });
  }

  Future<void> setSkipSilence(bool value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('skipSilence', value);
      return state.requireValue.copyWith(skipSilence: value);
    });
  }

  Future<void> setCrossfadeDuration(int value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('crossfadeDuration', value);
      return state.requireValue.copyWith(crossfadeDuration: value);
    });
  }

  Future<void> setLocale(String? value) async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      if (value != null) {
        await prefs.setString('locale', value);
      } else {
        await prefs.remove('locale');
      }
      return state.requireValue.copyWith(localeCode: value);
    });
  }
}
