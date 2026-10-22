import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ConfigRepository {
  Future<Map<String, dynamic>?> getConfig(String key);
  Future<void> saveConfig(String key, Map<String, dynamic> value);
}

class SharedPreferencesConfigRepository implements ConfigRepository {
  const SharedPreferencesConfigRepository();

  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(key);
    if (jsonStr == null) return null;
    try {
      return json.decode(jsonStr) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveConfig(String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }
}
