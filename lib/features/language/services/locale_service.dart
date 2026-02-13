import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/language/config/locale_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeService = Provider<LocaleService>((ref) => LocaleService());

class LocaleService {
  static const String _configKey = 'config_locale_settings';

  LocaleService();

  Future<LocaleConfig?> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('${_configKey}_languageCode');
    final countryCode = prefs.getString('${_configKey}_countryCode');
    
    if (languageCode != null) {
      return LocaleConfig(languageCode: languageCode, countryCode: countryCode ?? 'US');
    }
    return null;
  }

  Future<void> saveConfig(dynamic configOrLanguageCode, [String? countryCode]) async {
    final prefs = await SharedPreferences.getInstance();
    if (configOrLanguageCode is LocaleConfig) {
      await prefs.setString('${_configKey}_languageCode', configOrLanguageCode.languageCode);
      await prefs.setString('${_configKey}_countryCode', configOrLanguageCode.countryCode);
    } else if (configOrLanguageCode is String) {
      await prefs.setString('${_configKey}_languageCode', configOrLanguageCode);
      await prefs.setString('${_configKey}_countryCode', countryCode ?? 'US');
    }
  }
}