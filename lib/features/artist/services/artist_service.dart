import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// 歌手/创作者服务接口与标准实现
class ArtistService extends BaseService {
  late final Isar _isar;

  ArtistService([Isar? isar]) {
    _isar = isar ?? (GetIt.instance.isRegistered<Isar>() ? GetIt.instance<Isar>() : null as dynamic);
  }

  @override
  String get serviceId => 'artist_service';

  @override
  String get serviceName => 'Artist Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 获取歌手详情
  Future<ArtistModel?> getArtist(String artistId) async {
    try {
      final tracks = await _isar.trackEntitys
          .filter()
          .artistIdsElementEqualTo(artistId)
          .findAll();

      if (tracks.isEmpty) return null;

      final firstTrack = tracks.first;
      final artistNameIndex = firstTrack.artistIds?.indexOf(artistId) ?? -1;
      final name = (artistNameIndex >= 0 && artistNameIndex < (firstTrack.artistNames?.length ?? 0))
          ? firstTrack.artistNames![artistNameIndex]
          : 'Unknown Artist';

      return ArtistModel(
        id: artistId,
        platform: firstTrack.platform,
        name: name,
        imageUrl: firstTrack.imageUrl,
      );
    } catch (e) {
      return null;
    }
  }

  /// 获取歌手的所有专辑列表
  Future<List<AlbumModel>> getArtistAlbums(String artistId,
      {int limit = 20, int offset = 0}) async {
    try {
      final tracks = await _isar.trackEntitys
          .filter()
          .artistIdsElementEqualTo(artistId)
          .findAll();

      final Map<String, AlbumModel> albumMap = {};
      for (final track in tracks) {
        final albumName = track.albumName;
        if (albumName != null && albumName.isNotEmpty) {
          final albumId = track.albumId ?? albumName;
          if (!albumMap.containsKey(albumId)) {
            albumMap[albumId] = AlbumModel(
              id: albumId,
              platform: track.platform,
              name: albumName,
              imageUrl: track.imageUrl,
              artistIds: track.artistIds ?? [],
              artistNames: track.artistNames ?? [],
              totalTracks: 1,
            );
          }
        }
      }

      final list = albumMap.values.toList();
      final end = (offset + limit) > list.length ? list.length : offset + limit;
      if (offset >= list.length) return [];
      return list.sublist(offset, end);
    } catch (e) {
      return [];
    }
  }

  /// 获取歌手的热门热门单曲
  Future<List<TrackModel>> getArtistTopTracks(String artistId,
      {int limit = 10}) async {
    try {
      final entities = await _isar.trackEntitys
          .filter()
          .artistIdsElementEqualTo(artistId)
          .sortByPlayCountDesc()
          .limit(limit)
          .findAll();

      return entities.map((e) => e.toModel()).toList();
    } catch (e) {
      return [];
    }
  }

  /// 关注歌手
  Future<bool> followArtist(String artistId) async {
    return true;
  }

  /// 取消关注歌手
  Future<bool> unfollowArtist(String artistId) async {
    return true;
  }
}
