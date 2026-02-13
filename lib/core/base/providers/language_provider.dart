import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_provider.freezed.dart';
part 'language_provider.g.dart';

@freezed
abstract class LanguageState with _$LanguageState {
  const factory LanguageState({
    required Locale currentLocale,
    required List<Locale> supportedLocales,
    required Locale defaultLocale,
    @Default(false) bool isLoading,
  }) = _LanguageState;
}

/// 语言提供者
@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  static const String _languageCodeKey = 'language_code';
  static const String _countryCodeKey = 'country_code';

  @override
  LanguageState build() {
    // These should ideally be passed or loaded from config
    const defaultLocale = Locale('en');
    const supportedLocales = [
      Locale('en'),
      Locale('zh', 'CN'),
    ];

    _loadSavedLocale();

    return const LanguageState(
      currentLocale: defaultLocale,
      supportedLocales: supportedLocales,
      defaultLocale: defaultLocale,
    );
  }

  /// 加载保存的语言设置
  Future<void> _loadSavedLocale() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageCodeKey);
      final countryCode = prefs.getString(_countryCodeKey);

      if (languageCode != null) {
        final locale = Locale(languageCode, countryCode);
        if (_isSupported(locale)) {
          state = state.copyWith(currentLocale: locale, isLoading: false);
        } else {
          state = state.copyWith(isLoading: false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      debugPrint('加载语言设置失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// 设置语言
  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale)) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, locale.languageCode);
      if (locale.countryCode != null) {
        await prefs.setString(_countryCodeKey, locale.countryCode!);
      } else {
        await prefs.remove(_countryCodeKey);
      }

      state = state.copyWith(currentLocale: locale);
    } catch (e) {
      debugPrint('保存语言设置失败: $e');
    }
  }

  /// 检查语言是否支持
  bool _isSupported(Locale locale) {
    return state.supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode &&
        (supportedLocale.countryCode == null ||
            supportedLocale.countryCode == locale.countryCode));
  }

  /// 获取语言名称
  String getLanguageName(Locale locale) {
    final languageNames = {
      'en': '英语 (English)',
      'zh': '中文 (Chinese)',
      'zh_CN': '简体中文 (Simplified Chinese)',
      'zh_TW': '繁体中文 (Traditional Chinese)',
      'ja': '日语 (Japanese)',
      'ko': '韩语 (Korean)',
      'fr': '法语 (French)',
      'de': '德语 (German)',
      'es': '西班牙语 (Spanish)',
      'ru': '俄语 (Russian)',
      'ar': '阿拉伯语 (Arabic)',
      'pt': '葡萄牙语 (Portuguese)',
      'it': '意大利语 (Italian)',
    };

    final key = locale.countryCode != null
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;

    return languageNames[key] ?? key;
  }
}

