import 'package:music_source_protocol/music_source_protocol.dart';
import 'platform_registry_hub.dart';

class MultiSourceAggregator {
  final PlatformRegistryHub _hub;

  MultiSourceAggregator(this._hub);

  Future<List<TrackEntity>> searchAllSources(String query) async {
    final results = <TrackEntity>[];
    for (final platformId in _hub.availablePlatforms) {
      final searchDriver = _hub.getSearchDriver(platformId);
      if (searchDriver != null) {
        try {
          final tracks = await searchDriver.searchTracks(query);
          results.addAll(tracks);
        } catch (_) {}
      }
    }
    return results;
  }
}
