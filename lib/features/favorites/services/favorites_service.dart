import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// 收藏夹管理服务
class FavoritesService extends BaseService {
  late final Isar _isar;

  FavoritesService([Isar? isar]) {
    _isar = isar ?? (GetIt.instance.isRegistered<Isar>() ? GetIt.instance<Isar>() : null as dynamic);
  }

  @override
  String get serviceId => 'favorites_service';

  @override
  String get serviceName => 'Favorites Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 获取用户收藏的所有单曲
  Future<List<TrackModel>> getFavoriteTracks({int limit = 100, int offset = 0}) async {
    try {
      final entities = await _isar.trackEntitys
          .filter()
          .isFavoriteEqualTo(true)
          .offset(offset)
          .limit(limit)
          .findAll();

      return entities.map((e) => e.toModel()).toList();
    } catch (e) {
      return [];
    }
  }

  /// 切换收藏状态
  Future<bool> toggleFavorite(String trackId) async {
    final track = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    if (track != null) {
      return await _isar.writeTxn(() async {
        track.isFavorite = !track.isFavorite;
        await _isar.trackEntitys.put(track);
        return track.isFavorite;
      });
    }
    return false;
  }

  /// 检查是否已收藏
  Future<bool> isFavorite(String trackId) async {
    final track = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    return track?.isFavorite ?? false;
  }
}
