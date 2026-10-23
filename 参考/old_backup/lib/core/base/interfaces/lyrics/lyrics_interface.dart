import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';

/// 歌词接口
abstract class LyricsInterface {
  /// 歌词ID
  String get id;

  /// 关联的曲目
  TrackInterface get track;

  /// 歌词文本
  String get text;

  /// 是否为同步歌词
  bool get isSynced;

  /// 同步歌词时间戳，格式为 [时间点(毫秒), 歌词行]
  /// 如果不是同步歌词，则为空列表
  List<List<dynamic>> get syncedLyrics;

  /// 歌词语言
  String? get language;

  /// 歌词来源
  String? get source;
}
