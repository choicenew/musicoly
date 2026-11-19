abstract class PluginSourceDriver {
  String get pluginId;
  String get pluginName;
  String get pluginVersion;
  Future<void> loadScript(String scriptContent);
  Future<dynamic> invokeMethod(String methodName, [List<dynamic>? args]);
  Future<void> unload();
}
