import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/stats_model.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';

/// 播放统计服务实现 - 使用 Isar 持久化
class PlayStatsServiceImpl {
  static final PlayStatsServiceImpl _instance = PlayStatsServiceImpl._();
  factory PlayStatsServiceImpl() => _instance;
  PlayStatsServiceImpl._();

  late final Isar _isar;

  Future<void> initialize() async {
    _isar = GetIt.instance<Isar>();
  }

  Future<PlayStatsModel> recordPlay(TrackModel track,
      {int duration = 0, bool isComplete = false}) async {
    final now = DateTime.now();
    
    return await _isar.writeTxn(() async {
      var entity = await _isar.trackEntitys
          .filter()
          .trackIdEqualTo(track.id)
          .findFirst();

      if (entity == null) {
        entity = TrackEntity()
          ..trackId = track.id
          ..name = track.name
          ..platform = track.platform
          ..imageUrl = track.imageUrl
          ..artistIds = track.artistIds
          ..artistNames = track.artistNames
          ..albumId = track.albumId
          ..albumName = track.albumName
          ..durationMs = track.durationMs
          ..playCount = 1
          ..lastPlayedAt = now
          ..totalPlayDuration = duration
          ..skipCount = isComplete ? 0 : 1;
      } else {
        entity.playCount++;
        entity.lastPlayedAt = now;
        entity.totalPlayDuration += duration;
        if (!isComplete) {
          entity.skipCount++;
        }
      }

      await _isar.trackEntitys.put(entity);
      return _entityToStats(entity, track);
    });
  }

  Future<PlayStatsModel?> getTrackStats(TrackModel track) async {
    final entity = await _isar.trackEntitys
        .filter()
        .trackIdEqualTo(track.id)
        .findFirst();
    
    if (entity == null) return null;
    return _entityToStats(entity, track);
  }

  Future<List<PlayStatsModel>> getRecentPlays(
      {int limit = 20, int offset = 0}) async {
    final entities = await _isar.trackEntitys
        .where()
        .lastPlayedAtIsNotNull()
        .sortByLastPlayedAtDesc()
        .offset(offset)
        .limit(limit)
        .findAll();

    return entities.map((e) => _entityToStats(e)).toList();
  }

  Future<List<PlayStatsModel>> getTopTracks(
      {int limit = 20, int offset = 0}) async {
    final entities = await _isar.trackEntitys
        .where()
        .sortByPlayCountDesc()
        .offset(offset)
        .limit(limit)
        .findAll();

    return entities.map((e) => _entityToStats(e)).toList();
  }

  Future<int> getTotalPlayDuration() async {
    final entities = await _isar.trackEntitys.where().findAll();
    return entities.fold<int>(0, (sum, e) => sum + e.totalPlayDuration);
  }

  Future<int> getTotalPlayCount() async {
    final entities = await _isar.trackEntitys.where().findAll();
    return entities.fold<int>(0, (sum, e) => sum + e.playCount);
  }

  PlayStatsModel _entityToStats(TrackEntity entity, [TrackModel? track]) {
    final trackModel = track ?? TrackModel(
      id: entity.trackId,
      platform: entity.platform,
      name: entity.name,
      imageUrl: entity.imageUrl,
      artistIds: entity.artistIds ?? [],
      artistNames: entity.artistNames ?? [],
      albumId: entity.albumId,
      albumName: entity.albumName,
      durationMs: entity.durationMs,
      isPlayable: true,
      localPath: entity.localPath,
    );

    return PlayStatsModel(
      id: 'stats-${entity.trackId}',
      track: trackModel,
      playCount: entity.playCount,
      firstPlayed: entity.createdAt,
      lastPlayed: entity.lastPlayedAt ?? entity.createdAt,
      playDuration: entity.totalPlayDuration,
      isCompletePlay: true,
      skipCount: entity.skipCount,
      platform: entity.platform,
    );
  }
}
