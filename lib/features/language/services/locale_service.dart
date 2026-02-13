import 'package:pyro_music/features/language/config/locale_config.dart';
import 'package:config_package/config_package.dart';
import 'package:flutter/material.dart' show Locale;

class LocaleService {
  final ConfigRepository _configRepository;
  static const String _configKey = 'config_locale_settings';

  LocaleService(this._configRepository);

  Future<LocaleConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap != null 
      ? LocaleConfig.fromMap(configMap)
      : LocaleConfig(languageCode: 'en', countryCode: 'US');
  }

  Future<void> saveConfig(dynamic configOrLanguageCode, [String? countryCode]) async {
    if (configOrLanguageCode is LocaleConfig) {
      await _configRepository.saveConfig(_configKey, configOrLanguageCode.toMap());
    } else if (configOrLanguageCode is String) {
      final config = LocaleConfig(
        languageCode: configOrLanguageCode,
        countryCode: countryCode ?? 'US',
      );
      await _configRepository.saveConfig(_configKey, config.toMap());
    }
  }
}