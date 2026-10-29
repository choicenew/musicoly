import 'package:flutter/foundation.dart';
import 'package:pyro_music/features/plugin/contracts/plugin_port_contracts.dart';
import 'package:pyro_music/features/plugin/entities/media_entity.dart';

/// Central Plugin Registry for managing active dynamic plugin ports
class PluginRegistry {
  static final PluginRegistry _instance = PluginRegistry._internal();
  factory PluginRegistry() => _instance;
  PluginRegistry._internal();

  final Map<String, UniversalPluginPort> _plugins = {};
  final Set<String> _enabledPluginIds = {};

  /// Register a new plugin
  void registerPlugin(UniversalPluginPort plugin) {
    _plugins[plugin.manifest.id] = plugin;
    _enabledPluginIds.add(plugin.manifest.id);
  }

  /// Unregister a plugin
  void unregisterPlugin(String pluginId) {
    _plugins.remove(pluginId);
    _enabledPluginIds.remove(pluginId);
  }

  /// Enable or disable a plugin
  void setPluginEnabled(String pluginId, bool enabled) {
    if (enabled) {
      _enabledPluginIds.add(pluginId);
    } else {
      _enabledPluginIds.remove(pluginId);
    }
  }

  /// Get list of active enabled plugins
  List<UniversalPluginPort> get activePlugins => _plugins.values
      .where((p) => _enabledPluginIds.contains(p.manifest.id))
      .toList();

  /// Get plugins matching a specific capability
  List<UniversalPluginPort> getPluginsWithCapability(PluginCapability capability) {
    return activePlugins
        .where((p) => p.manifest.capabilities.contains(capability))
        .toList();
  }
}

/// Smart Router and Fallback Dispatcher for plugin requests
class PluginDispatcher {
  final PluginRegistry _registry;

  PluginDispatcher({PluginRegistry? registry})
      : _registry = registry ?? PluginRegistry();

  /// Aggregate explore sections from all plugins with 'explore' capability
  Future<List<HomeSectionEntity>> fetchExploreSections() async {
    final explorePlugins = _registry.getPluginsWithCapability(PluginCapability.explore);
    final List<HomeSectionEntity> aggregatedSections = [];

    for (final plugin in explorePlugins) {
      try {
        final sections = await plugin.fetchExploreSections();
        aggregatedSections.addAll(sections);
      } catch (e) {
        debugPrint('Error fetching explore sections from ${plugin.manifest.id}: $e');
      }
    }

    return aggregatedSections;
  }

  /// Unified multi-source search across all plugins with 'search' capability
  Future<List<MediaEntity>> search(
    String query, {
    int page = 1,
    int limit = 20,
    List<MediaType>? types,
  }) async {
    final searchPlugins = _registry.getPluginsWithCapability(PluginCapability.search);
    final List<MediaEntity> results = [];

    for (final plugin in searchPlugins) {
      try {
        final pluginResults = await plugin.search(
          query,
          page: page,
          limit: limit,
          types: types,
        );
        results.addAll(pluginResults);
      } catch (e) {
        debugPrint('Error searching from ${plugin.manifest.id}: $e');
      }
    }

    return results;
  }

  /// Stream resolution with automatic fallback chain
  Future<AudioStreamInfo?> resolveAudioStream(
    String trackId, {
    String? preferredPluginId,
    String? preferredQuality,
    String? preferredCodec,
  }) async {
    final streamPlugins = _registry.getPluginsWithCapability(PluginCapability.stream);
    if (streamPlugins.isEmpty) return null;

    // Prioritize preferred plugin if specified
    final sortedPlugins = List<UniversalPluginPort>.from(streamPlugins);
    if (preferredPluginId != null) {
      sortedPlugins.sort((a, b) {
        if (a.manifest.id == preferredPluginId) return -1;
        if (b.manifest.id == preferredPluginId) return 1;
        return 0;
      });
    }

    // Fallback chain: iterate over plugins until one returns a valid stream
    for (final plugin in sortedPlugins) {
      try {
        final streamInfo = await plugin.resolveAudioStream(
          trackId,
          preferredQuality: preferredQuality,
          preferredCodec: preferredCodec,
        );
        if (streamInfo.url.isNotEmpty) {
          return streamInfo;
        }
      } catch (e) {
        debugPrint('Stream resolution failed on ${plugin.manifest.id}, trying fallback... Error: $e');
      }
    }

    return null;
  }

  /// Dedicated lyrics resolution with fallback
  Future<String?> fetchLyrics(String trackId, {String? title, String? artist}) async {
    final lyricsPlugins = _registry.getPluginsWithCapability(PluginCapability.lyrics);

    for (final plugin in lyricsPlugins) {
      try {
        final lyrics = await plugin.fetchLyrics(trackId, title: title, artist: artist);
        if (lyrics != null && lyrics.isNotEmpty) {
          return lyrics;
        }
      } catch (e) {
        debugPrint('Lyrics resolution failed on ${plugin.manifest.id}: $e');
      }
    }

    return null;
  }
}
