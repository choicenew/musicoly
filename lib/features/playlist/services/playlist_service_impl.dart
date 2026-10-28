import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/features/playlist/services/playlist_service.dart';

/// Implementation of the playlist service
///
/// Provides cross-platform playlist management functionality
class PlaylistServiceImpl extends BaseService implements PlaylistService {
  /// The list of platform-specific playlist services
  final List<PlaylistService> platformServices;

  /// Create a new playlist service implementation
  ///
  /// Requires a list of platform-specific playlist services to delegate to
  PlaylistServiceImpl({required this.platformServices});

  // Implement missing BaseService methods
  @override
  String get serviceId => 'playlist_service';

  @override
  String get serviceName => 'Playlist Service';

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
  List<Type> getDependencies() => [PlaylistService];

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
  Future<List<TrackInterface>> getSmartPlaylistTracks(String type, {int limit = 50}) async {
    for (final service in platformServices) {
      try {
        final tracks = await service.getSmartPlaylistTracks(type, limit: limit);
        if (tracks.isNotEmpty) return tracks;
      } catch (e) {
        // Continue
      }
    }
    return [];
  }

  @override
  Future<void> dispose() async {
    for (final service in platformServices) {
      await service.dispose();
    }
  }

  // Implement missing PlaylistService methods
  @override
  Future<bool> deletePlaylist(String playlistId) async {
    for (final service in platformServices) {
      try {
        final success = await service.deletePlaylist(playlistId);
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }
    return false;
  }

  @override
  Future<bool> isFollowingPlaylist(String playlistId) async {
    for (final service in platformServices) {
      try {
        final isFollowing = await service.isFollowingPlaylist(playlistId);
        if (isFollowing) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }
    return false;
  }

  @override
  Future<bool> reorderPlaylistTracks({
    required String playlistId,
    required int rangeStart,
    required int rangeLength,
    required int insertBefore,
  }) async {
    for (final service in platformServices) {
      try {
        final success = await service.reorderPlaylistTracks(
          playlistId: playlistId,
          rangeStart: rangeStart,
          rangeLength: rangeLength,
          insertBefore: insertBefore,
        );
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }
    return false;
  }

  @override
  Future<List<PlaylistInterface>> getUserPlaylists(
      {int limit = 50, int offset = 0}) async {
    final allPlaylists = await Future.wait(
      platformServices.map(
          (service) => service.getUserPlaylists(limit: limit, offset: offset)),
    );

    return allPlaylists.expand((playlists) => playlists).take(limit).toList();
  }

  @override
  Future<PlaylistInterface?> getPlaylist(String playlistId) async {
    for (final service in platformServices) {
      try {
        final playlist = await service.getPlaylist(playlistId);
        if (playlist != null) {
          return playlist;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return null;
  }

  @override
  Future<List<TrackInterface>> getPlaylistTracks(String playlistId,
      {int limit = 100, int offset = 0}) async {
    for (final service in platformServices) {
      try {
        final tracks = await service.getPlaylistTracks(
          playlistId,
          limit: limit,
          offset: offset,
        );
        return tracks;
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return [];
  }

  @override
  Future<PlaylistInterface?> createPlaylist({
    required String name,
    String? description,
    bool public = false,
    bool collaborative = false,
  }) async {
    if (platformServices.isEmpty) return null;

    try {
      return await platformServices.first.createPlaylist(
        name: name,
        description: description,
        public: public,
        collaborative: collaborative,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updatePlaylist({
    required String playlistId,
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    for (final service in platformServices) {
      try {
        final success = await service.updatePlaylist(
          playlistId: playlistId,
          name: name,
          description: description,
          public: public,
          collaborative: collaborative,
        );
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return false;
  }

  @override
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int position = 0,
  }) async {
    for (final service in platformServices) {
      try {
        final success = await service.addTracksToPlaylist(
          playlistId: playlistId,
          trackIds: trackIds,
          position: position,
        );
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return false;
  }

  @override
  Future<bool> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    for (final service in platformServices) {
      try {
        final success = await service.removeTracksFromPlaylist(
          playlistId: playlistId,
          trackIds: trackIds,
        );
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return false;
  }

  @override
  Future<bool> followPlaylist(String playlistId) async {
    for (final service in platformServices) {
      try {
        final success = await service.followPlaylist(playlistId);
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return false;
  }

  @override
  Future<bool> unfollowPlaylist(String playlistId) async {
    for (final service in platformServices) {
      try {
        final success = await service.unfollowPlaylist(playlistId);
        if (success) {
          return true;
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return false;
  }

  @override
  Future<List<PlaylistInterface>> getFeaturedPlaylists(
      {int limit = 20, int offset = 0}) async {
    for (final service in platformServices) {
      try {
        final playlists = await service.getFeaturedPlaylists(limit: limit, offset: offset);
        if (playlists.isNotEmpty) return playlists;
      } catch (e) {
        // Continue
      }
    }
    return [];
  }

  Future<List<PlaylistInterface>> getCategoryPlaylists(String categoryId,
      {int limit = 20, int offset = 0}) async {
    final allPlaylists = <PlaylistInterface>[];
    
    for (final service in platformServices) {
      try {
        if (service is PlaylistServiceImpl) {
          final playlists = await service.getCategoryPlaylists(
            categoryId,
            limit: limit,
            offset: offset,
          );
          allPlaylists.addAll(playlists);
        }
      } catch (e) {
        // Continue to the next service if this one fails
      }
    }

    return allPlaylists.take(limit).toList();
  }

  @override
  Future<bool> toggleFavorite(String trackId) async {
    for (final service in platformServices) {
      try {
        final success = await service.toggleFavorite(trackId);
        if (success) return true;
      } catch (e) {
        // Continue
      }
    }
    return false;
  }

  @override
  Future<bool> isFavorite(String trackId) async {
    for (final service in platformServices) {
      try {
        final favorite = await service.isFavorite(trackId);
        if (favorite) return true;
      } catch (e) {
        // Continue
      }
    }
    return false;
  }
}
