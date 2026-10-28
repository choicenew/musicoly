import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/database/isar/entities/playlist_entity.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// 复合搜索结果对象
class AggregateSearchResults {
  final List<TrackModel> tracks;
  final List<AlbumModel> albums;
  final List<ArtistModel> artists;
  final List<PlaylistModel> playlists;

  const AggregateSearchResults({
    this.tracks = const [],
    this.albums = const [],
    this.artists = const [],
    this.playlists = const [],
  });
}

/// 全局搜索服务
class SearchService extends BaseService {
  late final Isar _isar;

  SearchService([Isar? isar]) {
    _isar = isar ?? (GetIt.instance.isRegistered<Isar>() ? GetIt.instance<Isar>() : null as dynamic);
  }

  @override
  String get serviceId => 'search_service';

  @override
  String get serviceName => 'Search Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 搜索单曲
  Future<List<TrackModel>> searchTracks(String query, {int limit = 20, int offset = 0}) async {
    try {
      final entities = await _isar.trackEntitys
          .filter()
          .nameContains(query, caseSensitive: false)
          .or()
          .artistNamesElementContains(query, caseSensitive: false)
          .offset(offset)
          .limit(limit)
          .findAll();

      return entities.map((e) => e.toModel()).toList();
    } catch (e) {
      return [];
    }
  }

  /// 搜索歌单
  Future<List<PlaylistModel>> searchPlaylists(String query, {int limit = 20, int offset = 0}) async {
    try {
      final entities = await _isar.playlistEntitys
          .filter()
          .nameContains(query, caseSensitive: false)
          .offset(offset)
          .limit(limit)
          .findAll();

      return entities.map((e) => PlaylistModel(
        id: e.playlistId,
        platform: e.platform,
        name: e.name,
        description: e.description,
        imageUrl: e.imageUrl,
        ownerName: e.author,
        totalTracks: e.trackIds?.length ?? 0,
      )).toList();
    } catch (e) {
      return [];
    }
  }

  /// 综合搜索（单曲 + 专辑 + 歌手 + 歌单）
  Future<AggregateSearchResults> searchAll(String query, {int limit = 20, int offset = 0}) async {
    final tracks = await searchTracks(query, limit: limit, offset: offset);
    final playlists = await searchPlaylists(query, limit: limit, offset: offset);

    return AggregateSearchResults(
      tracks: tracks,
      playlists: playlists,
    );
  }

  /// 获取搜索联想词建议
  Future<List<String>> getSearchSuggestions(String partialQuery, {int limit = 5}) async {
    if (partialQuery.trim().isEmpty) return [];
    final tracks = await searchTracks(partialQuery, limit: limit);
    return tracks.map((t) => t.name).toSet().toList();
  }
}
