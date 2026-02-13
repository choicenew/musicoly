import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';

/// 播放统计接口
abstract class PlayStatsInterface {
  /// 统计ID
  String get id;

  /// 关联的曲目
  TrackInterface get track;

  /// 播放次数
  int get playCount;

  /// 首次播放时间
  DateTime get firstPlayed;

  /// 最后播放时间
  DateTime get lastPlayed;

  /// 播放时长(秒)
  int get playDuration;

  /// 是否完整播放
  bool get isCompletePlay;

  /// 跳过次数
  int get skipCount;
}
