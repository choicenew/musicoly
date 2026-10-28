import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/stats_model.dart';

/// 艺术家统计服务实现
class ArtistStatsServiceImpl {
  static final ArtistStatsServiceImpl _instance = ArtistStatsServiceImpl._();
  factory ArtistStatsServiceImpl() => _instance;
  ArtistStatsServiceImpl._();

  final Map<String, ArtistStatsModel> _artistStats = {};

  Future<ArtistStatsModel?> getArtistStats(ArtistModel artist) async {
    return _artistStats[artist.id];
  }

  Future<List<ArtistStatsModel>> getTopArtists(
      {int limit = 20, int offset = 0}) async {
    final sorted = _artistStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));

    final end =
        (offset + limit) > sorted.length ? sorted.length : offset + limit;

    if (offset >= sorted.length) return [];

    return sorted.sublist(offset, end);
  }

  Future<void> updateArtistStats(TrackModel track, int duration) async {
    for (var i = 0; i < track.artistIds.length; i++) {
      final artistId = track.artistIds[i];
      final artistName = track.artistNames[i];
      final now = DateTime.now();

      final artist = ArtistModel(
        id: artistId,
        platform: 'local',
        name: artistName,
      );

      if (_artistStats.containsKey(artistId)) {
        final stats = _artistStats[artistId]!;

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
        final newStats = ArtistStatsModel(
          id: 'artist-stats-$artistId',
          artist: artist,
          playCount: 1,
          firstPlayed: now,
          lastPlayed: now,
          totalPlayDuration: duration,
          platform: 'local',
        );

        _artistStats[artistId] = newStats;
      }
    }
  }

  Future<void> dispose() async {
    _artistStats.clear();
  }
}
