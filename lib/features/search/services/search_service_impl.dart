import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/services/search_service.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/album_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';

/// Implementation of the search service
///
/// Provides cross-platform search functionality by aggregating results
/// from multiple music platforms
class SearchServiceImpl extends SearchService {
  /// The list of platform-specific search services
  final List<SearchService> platformServices;

  /// Create a new search service implementation
  ///
  /// Requires a list of platform-specific search services to delegate to
  SearchServiceImpl({required this.platformServices});

  // Implement missing BaseService methods
  @override
  String get serviceId => 'search_service';

  @override
  String get serviceName => 'Search Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // Cross-platform service

  @override
  Map<String, dynamic> getConfig() => {
        'platformCount': platformServices.length,
        'platforms': platformServices.map((s) => s.serviceId).toList(),
      };

  @override
  List<Type> getDependencies() => [SearchService];

  @override
  ServiceStatus getStatus() => 
      platformServices.isEmpty ? ServiceStatus.notConfigured : ServiceStatus.available;

  @override
  Future<void> initialize() async {
    for (final service in platformServices) {
      await service.initialize();
    }
  }

  @override
  Future<void> dispose() async {
    for (final service in platformServices) {
      await service.dispose();
    }
  }

  @override
  Future<List<TrackInterface>> searchTracks(String query,
      {int limit = 20, int offset = 0}) async {
    // Distribute the limit across all platform services
    final perPlatformLimit = (limit / platformServices.length).ceil();

    // Collect results from all platforms
    final results = await Future.wait(
      platformServices.map((service) =>
          service.searchTracks(query, limit: perPlatformLimit, offset: offset)),
    );

    // Flatten and limit the results
    return results.expand((tracks) => tracks).take(limit).toList();
  }

  @override
  Future<List<AlbumInterface>> searchAlbums(String query,
      {int limit = 20, int offset = 0}) async {
    final perPlatformLimit = (limit / platformServices.length).ceil();

    final results = await Future.wait(
      platformServices.map((service) =>
          service.searchAlbums(query, limit: perPlatformLimit, offset: offset)),
    );

    return results.expand((albums) => albums).take(limit).toList();
  }

  @override
  Future<List<ArtistInterface>> searchArtists(String query,
      {int limit = 20, int offset = 0}) async {
    final perPlatformLimit = (limit / platformServices.length).ceil();

    final results = await Future.wait(
      platformServices.map((service) => service.searchArtists(query,
          limit: perPlatformLimit, offset: offset)),
    );

    return results.expand((artists) => artists).take(limit).toList();
  }

  @override
  Future<List<PlaylistInterface>> searchPlaylists(String query,
      {int limit = 20, int offset = 0}) async {
    final perPlatformLimit = (limit / platformServices.length).ceil();

    final results = await Future.wait(
      platformServices.map((service) => service.searchPlaylists(query,
          limit: perPlatformLimit, offset: offset)),
    );

    return results.expand((playlists) => playlists).take(limit).toList();
  }

  @override
  Future<SearchResults> search(String query,
      {int limit = 20, int offset = 0}) async {
    // Distribute the search across platforms and collect results
    final perPlatformLimit = (limit / platformServices.length).ceil();

    final platformResults = await Future.wait(
      platformServices.map((service) =>
          service.search(query, limit: perPlatformLimit, offset: offset)),
    );

    // Combine results from all platforms
    final tracks =
        platformResults.expand((result) => result.tracks).take(limit).toList();

    final albums =
        platformResults.expand((result) => result.albums).take(limit).toList();

    final artists =
        platformResults.expand((result) => result.artists).take(limit).toList();

    final playlists = platformResults
        .expand((result) => result.playlists)
        .take(limit)
        .toList();

    return SearchResults(
      tracks: tracks,
      albums: albums,
      artists: artists,
      playlists: playlists,
    );
  }

  @override
  Future<Map<String, List<dynamic>>> searchAll(String query,
      {int limit = 20, int offset = 0}) async {
    final results = await search(query, limit: limit, offset: offset);

    return {
      'tracks': results.tracks,
      'albums': results.albums,
      'artists': results.artists,
      'playlists': results.playlists,
    };
  }

  @override
  Future<List<String>> getSearchSuggestions(String partialQuery,
      {int limit = 5}) async {
    // Collect suggestions from all platforms
    final allSuggestions = await Future.wait(
      platformServices.map((service) =>
          service.getSearchSuggestions(partialQuery, limit: limit)),
    );

    // Combine and deduplicate suggestions
    final suggestions = allSuggestions
        .expand((suggestions) => suggestions)
        .toSet()
        .take(limit)
        .toList();

    return suggestions;
  }
}
