import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';

/// 艺术家统计接口
abstract class ArtistStatsInterface {
  /// 统计ID
  String get id;

  /// 关联的艺术家
  ArtistInterface get artist;

  /// 播放次数
  int get playCount;

  /// 首次播放时间
  DateTime get firstPlayed;

  /// 最后播放时间
  DateTime get lastPlayed;

  /// 总播放时长(秒)
  int get totalPlayDuration;
}
