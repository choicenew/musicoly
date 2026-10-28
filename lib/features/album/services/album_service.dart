import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// 专辑服务接口与标准实现
class AlbumService extends BaseService {
  late final Isar _isar;

  AlbumService([Isar? isar]) {
    _isar = isar ?? (GetIt.instance.isRegistered<Isar>() ? GetIt.instance<Isar>() : null as dynamic);
  }

  @override
  String get serviceId => 'album_service';

  @override
  String get serviceName => 'Album Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 根据 ID 获取专辑元数据
  Future<AlbumModel?> getAlbum(String albumId) async {
    try {
      final tracks = await _isar.trackEntitys
          .filter()
          .albumIdEqualTo(albumId)
          .findAll();

      if (tracks.isEmpty) return null;

      final firstTrack = tracks.first;
      return AlbumModel(
        id: albumId,
        platform: firstTrack.platform,
        name: firstTrack.albumName ?? 'Unknown Album',
        imageUrl: firstTrack.imageUrl,
        artistIds: firstTrack.artistIds ?? [],
        artistNames: firstTrack.artistNames ?? [],
        totalTracks: tracks.length,
      );
    } catch (e) {
      return null;
    }
  }

  /// 获取专辑包含的所有单曲列表
  Future<List<TrackModel>> getAlbumTracks(String albumId,
      {int limit = 50, int offset = 0}) async {
    try {
      final entities = await _isar.trackEntitys
          .filter()
          .albumIdEqualTo(albumId)
          .offset(offset)
          .limit(limit)
          .findAll();

      return entities.map((e) => e.toModel()).toList();
    } catch (e) {
      return [];
    }
  }

  /// 获取新发行或近期的本地专辑
  Future<List<AlbumModel>> getNewReleases({int limit = 20, int offset = 0}) async {
    try {
      final tracks = await _isar.trackEntitys
          .where()
          .sortByCreatedAtDesc()
          .limit(100)
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

  /// 保存/收藏专辑
  Future<bool> saveAlbum(String albumId) async {
    return true;
  }

  /// 移除已收藏专辑
  Future<bool> removeAlbum(String albumId) async {
    return true;
  }
}
