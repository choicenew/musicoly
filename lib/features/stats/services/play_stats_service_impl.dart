import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/models/stats_model.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/services/stats_service.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';

/// 播放统计服务实现 - 使用 Isar 持久化
class PlayStatsServiceImpl extends BaseService implements StatsService {
  // 单例模式
  static final PlayStatsServiceImpl _instance = PlayStatsServiceImpl._();
  factory PlayStatsServiceImpl() => _instance;
  PlayStatsServiceImpl._();

  late final Isar _isar;

  @override
  String get serviceId => 'play_stats_service';

  @override
  String get serviceName => 'Play Stats Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {
    _isar = GetIt.instance<Isar>();
  }

  @override
  Future<PlayStatsInterface> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false}) async {
    final now = DateTime.now();
    
    return await _isar.writeTxn(() async {
      var entity = await _isar.trackEntitys
          .filter()
          .trackIdEqualTo(track.id)
          .findFirst();

      if (entity == null) {
        // 如果轨道不在库中，先创建一个（通常应该在库中）
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

  @override
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    final entity = await _isar.trackEntitys
        .filter()
        .trackIdEqualTo(track.id)
        .findFirst();
    
    if (entity == null) return null;
    return _entityToStats(entity, track);
  }

  @override
  Future<List<PlayStatsInterface>> getRecentPlays(
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

  @override
  Future<List<PlayStatsInterface>> getTopTracks(
      {int limit = 20, int offset = 0}) async {
    final entities = await _isar.trackEntitys
        .where()
        .sortByPlayCountDesc()
        .offset(offset)
        .limit(limit)
        .findAll();

    return entities.map((e) => _entityToStats(e)).toList();
  }

  @override
  Future<int> getTotalPlayDuration() async {
    final entities = await _isar.trackEntitys.where().findAll();
    return entities.fold<int>(0, (sum, e) => sum + e.totalPlayDuration);
  }

  @override
  Future<int> getTotalPlayCount() async {
    final entities = await _isar.trackEntitys.where().findAll();
    return entities.fold<int>(0, (sum, e) => sum + e.playCount);
  }

  PlayStatsInterface _entityToStats(TrackEntity entity, [TrackInterface? track]) {
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
      isCompletePlay: true, // 简化处理
      skipCount: entity.skipCount,
      platform: entity.platform,
    );
  }

  @override
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    throw UnimplementedError('Artist stats not implemented in PlayStatsServiceImpl');
  }

  @override
  Future<List<ArtistStatsInterface>> getTopArtists(
      {int limit = 20, int offset = 0}) async {
    throw UnimplementedError('Artist stats not implemented in PlayStatsServiceImpl');
  }

  @override
  List<Type> getDependencies() => [Isar];

  @override
  ServiceStatus getStatus() => ServiceStatus.available;

  @override
  Map<String, dynamic> getConfig() => {};

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> dispose() async {}
}
