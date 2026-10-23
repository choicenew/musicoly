import 'package:pyro_music/features/plugin/plugin_source_contract.dart';
import 'ad_section_plugin.dart';
import 'default_local_plugin.dart';

/// Sandbox & Host Runtime Manager for Dynamic External Plugins
class PluginRuntimeContainer {
  static final PluginRuntimeContainer _instance =
      PluginRuntimeContainer._internal();
  factory PluginRuntimeContainer() => _instance;

  final Map<String, PluginSourceContract> _plugins = {};

  PluginRuntimeContainer._internal() {
    // Register built-in default local plugin & ad plugin
    registerPlugin(DefaultLocalPlugin());
    registerPlugin(AdSectionPlugin());
  }

  /// Register an external or built-in dynamic plugin
  void registerPlugin(PluginSourceContract plugin) {
    _plugins[plugin.pluginId] = plugin;
  }

  /// Unregister a plugin by ID
  void unregisterPlugin(String pluginId) {
    _plugins.remove(pluginId);
  }

  /// Get plugin instance by ID
  PluginSourceContract? getPlugin(String pluginId) {
    return _plugins[pluginId];
  }

  /// Get list of all currently active plugins
  List<PluginSourceContract> getActivePlugins() {
    return _plugins.values.toList();
  }

  /// Get all active plugin IDs
  List<String> getActivePluginIds() {
    return _plugins.keys.toList();
  }
}
