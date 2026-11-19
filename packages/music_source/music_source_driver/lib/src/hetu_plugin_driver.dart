import 'package:music_source_protocol/music_source_protocol.dart';

class HetuPluginDriver implements PluginSourceDriver {
  final String _id;
  final String _name;
  final String _version;

  HetuPluginDriver({
    required String id,
    required String name,
    required String version,
  })  : _id = id,
        _name = name,
        _version = version;

  @override
  String get pluginId => _id;

  @override
  String get pluginName => _name;

  @override
  String get pluginVersion => _version;

  @override
  Future<void> loadScript(String scriptContent) async {}

  @override
  Future<dynamic> invokeMethod(String methodName, [List<dynamic>? args]) async => null;

  @override
  Future<void> unload() async {}
}
