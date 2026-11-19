import 'package:music_source_protocol/music_source_protocol.dart';
import 'platform_service_error.dart';

class PlatformRegistryHub {
  static final PlatformRegistryHub _instance = PlatformRegistryHub._internal();
  factory PlatformRegistryHub() => _instance;
  PlatformRegistryHub._internal();

  final Map<String, TrackSourceDriver> _trackDrivers = {};
  final Map<String, SearchSourceDriver> _searchDrivers = {};
  final Map<String, LyricsSourceDriver> _lyricsDrivers = {};
  final Map<String, PluginSourceDriver> _pluginDrivers = {};

  String _activePlatformId = '';

  String get activePlatformId => _activePlatformId;
  set activePlatformId(String id) {
    if (_trackDrivers.containsKey(id)) {
      _activePlatformId = id;
    }
  }

  void registerTrackDriver(TrackSourceDriver driver) {
    _trackDrivers[driver.platformId] = driver;
    if (_activePlatformId.isEmpty) {
      _activePlatformId = driver.platformId;
    }
  }

  void registerSearchDriver(SearchSourceDriver driver) {
    _searchDrivers[driver.platformId] = driver;
  }

  void registerLyricsDriver(LyricsSourceDriver driver) {
    _lyricsDrivers[driver.platformId] = driver;
  }

  void registerPluginDriver(PluginSourceDriver driver) {
    _pluginDrivers[driver.pluginId] = driver;
  }

  TrackSourceDriver? getTrackDriver(String platformId) => _trackDrivers[platformId];
  SearchSourceDriver? getSearchDriver(String platformId) => _searchDrivers[platformId];
  LyricsSourceDriver? getLyricsDriver(String platformId) => _lyricsDrivers[platformId];
  PluginSourceDriver? getPluginDriver(String pluginId) => _pluginDrivers[pluginId];

  List<String> get availablePlatforms => _trackDrivers.keys.toList();

  Future<void> autoDiscoverAndRegister() async {
    for (final driver in _trackDrivers.values) {
      try {
        await driver.initialize();
      } catch (e) {
        throw PlatformServiceError.fromPlatformError(e);
      }
    }
  }

  Future<void> disposeAll() async {
    for (final driver in _trackDrivers.values) {
      await driver.dispose();
    }
    _trackDrivers.clear();
    _searchDrivers.clear();
    _lyricsDrivers.clear();
    _pluginDrivers.clear();
  }
}
