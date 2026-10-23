import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/models/stats_model.dart';
import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/services/stats_service.dart';

/// 播放统计服务实现
class PlayStatsServiceImpl extends BaseService implements StatsService {
  // 单例模式
  static final PlayStatsServiceImpl _instance = PlayStatsServiceImpl._();
  factory PlayStatsServiceImpl() => _instance;
  PlayStatsServiceImpl._();

  @override
  String get serviceId => 'play_stats_service';

  @override
  String get serviceName => 'Play Stats Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // 不依赖特定平台

  // 内存中存储播放统计数据
  final Map<String, PlayStatsModel> _playStats = {};
  final List<PlayStatsModel> _recentPlays = [];

  @override
  Future<PlayStatsInterface> recordPlay(TrackInterface track,
      {int duration = 0, bool isComplete = false}) async {
    final trackId = track.id;
    final now = DateTime.now();

    // 检查是否已有该曲目的统计
    if (_playStats.containsKey(trackId)) {
      final stats = _playStats[trackId]!;

      // 更新统计数据
      final updatedStats = PlayStatsModel(
        id: stats.id,
        track: track,
        playCount: stats.playCount + 1,
        firstPlayed: stats.firstPlayed,
        lastPlayed: now,
        playDuration: stats.playDuration + duration,
        isCompletePlay: isComplete,
        skipCount: !isComplete ? stats.skipCount + 1 : stats.skipCount,
        platform: stats.platform,
      );

      _playStats[trackId] = updatedStats;

      // 更新最近播放列表
      _recentPlays.removeWhere((item) => item.track.id == trackId);
      _recentPlays.insert(0, updatedStats);

      return updatedStats;
    } else {
      // 创建新的统计数据
      final newStats = PlayStatsModel(
        id: 'play-stats-$trackId',
        track: track,
        playCount: 1,
        firstPlayed: now,
        lastPlayed: now,
        playDuration: duration,
        isCompletePlay: false,
        skipCount: !isComplete ? 1 : 0,
        platform: 'default',
      );

      _playStats[trackId] = newStats;
      _recentPlays.insert(0, newStats);

      return newStats;
    }
  }

  @override
  Future<PlayStatsInterface?> getTrackStats(TrackInterface track) async {
    return _playStats[track.id];
  }

  @override
  Future<List<PlayStatsInterface>> getRecentPlays(
      {int limit = 20, int offset = 0}) async {
    final end = (offset + limit) > _recentPlays.length
        ? _recentPlays.length
        : offset + limit;

    if (offset >= _recentPlays.length) return [];

    return _recentPlays.sublist(offset, end);
  }

  @override
  Future<List<PlayStatsInterface>> getTopTracks(
      {int limit = 20, int offset = 0}) async {
    // 按播放次数排序
    final sorted = _playStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));

    final end =
        (offset + limit) > sorted.length ? sorted.length : offset + limit;

    if (offset >= sorted.length) return [];

    return sorted.sublist(offset, end);
  }

  @override
  Future<int> getTotalPlayDuration() async {
    // Use int for accumulation to avoid FutureOr<int> type error
    final total = _playStats.values
        .fold<int>(0, (sum, stats) => sum + stats.playDuration);
    return total;
  }

  @override
  Future<int> getTotalPlayCount() async {
    // Use int for accumulation to avoid FutureOr<int> type error
    final total =
        _playStats.values.fold<int>(0, (sum, stats) => sum + stats.playCount);
    return total;
  }

  @override
  Future<ArtistStatsInterface?> getArtistStats(ArtistInterface artist) async {
    // 委托给ArtistStatsServiceImpl处理
    throw UnimplementedError('请使用ArtistStatsServiceImpl');
  }

  @override
  Future<List<ArtistStatsInterface>> getTopArtists(
      {int limit = 20, int offset = 0}) async {
    // 委托给ArtistStatsServiceImpl处理
    throw UnimplementedError('请使用ArtistStatsServiceImpl');
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
    _playStats.clear();
    _recentPlays.clear();
  }
}
