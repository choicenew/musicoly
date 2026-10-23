import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/database/isar/entities/playlist_entity.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';

class LocalPlaylistService extends PlaylistService {
  final Isar _isar;

  LocalPlaylistService(this._isar);

  @override
  String get serviceId => 'local_playlist';

  @override
  String get serviceName => 'Local Playlist Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => 'local';

  @override
  Future<void> initialize() async {}

  @override
  Future<List<PlaylistInterface>> getUserPlaylists({int limit = 50, int offset = 0}) async {
    final entities = await _isar.playlistEntitys
        .filter()
        .platformEqualTo('local')
        .offset(offset)
        .limit(limit)
        .findAll();
    return entities.map(_entityToModel).toList();
  }

  @override
  Future<PlaylistInterface?> getPlaylist(String playlistId) async {
    final entity = await _isar.playlistEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findFirst();
    return entity != null ? _entityToModel(entity) : null;
  }

  @override
  Future<List<TrackInterface>> getPlaylistTracks(String playlistId, {int limit = 100, int offset = 0}) async {
    final entity = await _isar.playlistEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findFirst();
    
    if (entity == null || entity.trackIds == null) return [];

    final trackIds = entity.trackIds!;
    final tracks = <TrackInterface>[];
    
    for (final id in trackIds.skip(offset).take(limit)) {
      final trackEntity = await _isar.trackEntitys.filter().trackIdEqualTo(id).findFirst();
      if (trackEntity != null) {
        tracks.add(_trackEntityToModel(trackEntity));
      }
    }
    return tracks;
  }

  @override
  Future<PlaylistInterface?> createPlaylist({
    required String name,
    String? description,
    bool public = false,
    bool collaborative = false,
  }) async {
    final entity = PlaylistEntity()
      ..playlistId = 'local_${DateTime.now().microsecondsSinceEpoch}'
      ..name = name
      ..description = description
      ..platform = 'local'
      ..trackIds = [];

    await _isar.writeTxn(() async {
      await _isar.playlistEntitys.put(entity);
    });
    return _entityToModel(entity);
  }

  @override
  Future<bool> updatePlaylist({
    required String playlistId,
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    final entity = await _isar.playlistEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findFirst();
    
    if (entity == null) return false;

    if (name != null) entity.name = name;
    if (description != null) entity.description = description;

    await _isar.writeTxn(() async {
      await _isar.playlistEntitys.put(entity);
    });
    return true;
  }

  @override
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
    int position = 0,
  }) async {
    final entity = await _isar.playlistEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findFirst();
    
    if (entity == null) return false;

    final currentIds = entity.trackIds?.toList() ?? [];
    // Insert at position, or at the end if position is out of bounds
    if (position >= 0 && position <= currentIds.length) {
      currentIds.insertAll(position, trackIds);
    } else {
      currentIds.addAll(trackIds);
    }
    
    // Remove duplicates while preserving order
    final seen = <String>{};
    final uniqueIds = currentIds.where((id) => seen.add(id)).toList();
    entity.trackIds = uniqueIds;

    await _isar.writeTxn(() async {
      await _isar.playlistEntitys.put(entity);
    });
    return true;
  }

  @override
  Future<bool> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    final entity = await _isar.playlistEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findFirst();
    
    if (entity == null) return false;

    final currentIds = entity.trackIds?.toList() ?? [];
    currentIds.removeWhere((id) => trackIds.contains(id));
    entity.trackIds = currentIds;

    await _isar.writeTxn(() async {
      await _isar.playlistEntitys.put(entity);
    });
    return true;
  }

  @override
  Future<bool> deletePlaylist(String playlistId) async {
    return await _isar.writeTxn(() async {
      return await _isar.playlistEntitys
          .filter()
          .playlistIdEqualTo(playlistId)
          .deleteAll() > 0;
    });
  }

  @override
  Future<List<TrackInterface>> getSmartPlaylistTracks(String type, {int limit = 50}) async {
    List<TrackEntity> entities;
    switch (type) {
      case 'recently_added':
        entities = await _isar.trackEntitys
            .where()
            .sortByCreatedAtDesc()
            .limit(limit)
            .findAll();
        break;
      case 'recently_played':
        entities = await _isar.trackEntitys
            .where()
            .filter()
            .lastPlayedAtIsNotNull()
            .sortByLastPlayedAtDesc()
            .limit(limit)
            .findAll();
        break;
      case 'most_played':
        entities = await _isar.trackEntitys
            .where()
            .sortByPlayCountDesc()
            .limit(limit)
            .findAll();
        break;
      default:
        return [];
    }
    return entities.map(_trackEntityToModel).toList();
  }

  PlaylistModel _entityToModel(PlaylistEntity entity) {
    return PlaylistModel(
      id: entity.playlistId,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      ownerName: entity.author,
      platform: entity.platform,
      totalTracks: entity.trackIds?.length ?? 0,
    );
  }

  TrackModel _trackEntityToModel(TrackEntity entity) {
    return TrackModel(
      id: entity.trackId,
      platform: entity.platform,
      name: entity.name,
      imageUrl: entity.imageUrl,
      artistIds: entity.artistIds ?? [],
      artistNames: entity.artistNames ?? [],
      albumId: entity.albumId,
      albumName: entity.albumName,
      durationMs: entity.durationMs,
      isPlayable: entity.isPlayable,
      previewUrl: entity.previewUrl,
      isFavorite: entity.isFavorite,
    );
  }
  
  @override
  Future<bool> followPlaylist(String playlistId) async => false;
  
  @override
  Future<List<PlaylistInterface>> getFeaturedPlaylists({int limit = 20, int offset = 0}) async => [];
  
  @override
  Future<bool> isFollowingPlaylist(String playlistId) async => false;
  
  @override
  Future<bool> reorderPlaylistTracks({required String playlistId, required int rangeStart, required int insertBefore, required int rangeLength}) async => false;
  
  @override
  Future<bool> unfollowPlaylist(String playlistId) async => false;

  @override
  Future<bool> toggleFavorite(String trackId) async {
    final track = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    if (track != null) {
      await _isar.writeTxn(() async {
        track.isFavorite = !track.isFavorite;
        await _isar.trackEntitys.put(track);
      });
      return track.isFavorite;
    }
    return false;
  }

  @override
  Future<bool> isFavorite(String trackId) async {
    final track = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    return track?.isFavorite ?? false;
  }
}
