import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/models/stats_model.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/services/stats_service.dart';

/// 艺术家统计服务实现
class ArtistStatsServiceImpl extends BaseService implements StatsService {
  // 单例模式
  static final ArtistStatsServiceImpl _instance = ArtistStatsServiceImpl._();
  factory ArtistStatsServiceImpl() => _instance;
  ArtistStatsServiceImpl._();

  @override
  String get serviceId => 'artist_stats_service';

  @override
  String get serviceName => 'Artist Stats Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // 不依赖特定平台

  // 内存中存储艺术家统计数据
  final Map<String, ArtistStatsModel> _artistStats = {};

  @override
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    return _artistStats[artist.id];
  }

  @override
  Future<List<ArtistStatsInterface>> getTopArtists(
      {int limit = 20, int offset = 0}) async {
    // 按播放次数排序
    final sorted = _artistStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));

    final end =
        (offset + limit) > sorted.length ? sorted.length : offset + limit;

    if (offset >= sorted.length) return [];

    return sorted.sublist(offset, end);
  }

  // 更新艺术家统计数据
  Future<void> _updateArtistStats(TrackInterface track, int duration) async {
    // 遍历曲目的所有艺术家
    for (var i = 0; i < track.artistIds.length; i++) {
      final artistId = track.artistIds[i];
      final artistName = track.artistNames[i];
      final now = DateTime.now();

      // 创建简单的艺术家对象
      final artist = SimpleArtistModel(
        id: artistId,
        name: artistName,
        imageUrl: null,
      );

      // 检查是否已有该艺术家的统计
      if (_artistStats.containsKey(artistId)) {
        final stats = _artistStats[artistId]!;

        // 更新统计数据
        final updatedStats = ArtistStatsModel(
          id: stats.id,
          artist: artist,
          playCount: stats.playCount + 1,
          firstPlayed: stats.firstPlayed,
          lastPlayed: now,
          totalPlayDuration: stats.totalPlayDuration + duration,
          platform: stats.platform,
        );

        _artistStats[artistId] = updatedStats;
      } else {
        // 创建新的统计数据
        final newStats = ArtistStatsModel(
          id: 'artist-stats-$artistId',
          artist: artist,
          playCount: 1,
          firstPlayed: now,
          lastPlayed: now,
          totalPlayDuration: duration,
          platform: 'default',
        );

        _artistStats[artistId] = newStats;
      }
    }
  }

  @override
  Future<PlayStatsInterface> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false}) async {
    // 更新艺术家统计
    await _updateArtistStats(track, duration);

    // 委托给PlayStatsServiceImpl处理曲目统计
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    // 委托给PlayStatsServiceImpl处理
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<List<PlayStatsInterface>> getRecentPlays(
      {int limit = 20, int offset = 0}) async {
    // 委托给PlayStatsServiceImpl处理
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<List<PlayStatsInterface>> getTopTracks(
      {int limit = 20, int offset = 0}) async {
    // 委托给PlayStatsServiceImpl处理
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<int> getTotalPlayDuration() async {
    // 委托给PlayStatsServiceImpl处理
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<int> getTotalPlayCount() async {
    // 委托给PlayStatsServiceImpl处理
    throw UnimplementedError('请使用PlayStatsServiceImpl');
  }

  @override
  Future<void> initialize() async {
    // 初始化逻辑，例如从数据库加载数据
    // 这里简化为空实现
  }

  @override
  List<Type> getDependencies() => [];

  @override
  ServiceStatus getStatus() => ServiceStatus.available;

  @override
  Map<String, dynamic> getConfig() => {};

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> dispose() async {
    // 清理资源
    _artistStats.clear();
  }
}

/// 简单的艺术家模型，用于统计
class SimpleArtistModel implements ArtistInterface {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? imageUrl;

  @override
  List<String>? get genres => null;

  @override
  int? get popularity => null;

  @override
  int? get followersCount => null;

  @override
  String? get description => null;

  @override
  String get platform => 'default';

  @override
  final Map<String, dynamic> platformMetadata = {};

  SimpleArtistModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };
}
