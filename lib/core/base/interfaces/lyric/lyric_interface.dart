import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/services/base_service.dart';

/// 歌词行模型
@immutable
class LyricLine {
  final Duration startTime;
  final String text;
  final String? translation;

  const LyricLine({
    required this.startTime,
    required this.text,
    this.translation,
  });
}

/// 歌词数据接口
abstract class LyricData {
  /// 所有歌词行
  List<LyricLine> get lines;

  /// 歌词来源标识 (插件ID)
  String get sourceId;

  /// 关联的曲目名称 (用于搜索结果显示)
  String get trackName;

  /// 关联的艺术家名称 (用于搜索结果显示)
  String get artistNames;

  /// 歌词元数据
  Map<String, dynamic> get metadata;

  /// 是否是同步歌词
  bool get isSynced;
}

/// 歌词解析插件接口
abstract class LyricPlugin extends BaseService {
  /// 插件标识
  String get pluginId;

  /// 根据曲目 ID 或元数据搜索并获取歌词
  Future<LyricData?> fetchLyric(String trackId, {Map<String, dynamic>? metadata});

  /// 搜索歌词
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0});

  /// 保存歌词
  Future<bool> saveLyric(String trackId, LyricData lyric);
}

/// 歌词管理器
abstract class LyricManager extends BaseService {
  /// 获取所有已注册的歌词插件
  List<String> get availablePlugins;

  /// 获取歌词 (按优先级尝试所有插件)
  Future<LyricData?> getLyric(String trackId, {Map<String, dynamic>? metadata});

  /// 搜索歌词
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0});

  /// 保存歌词
  Future<bool> saveLyric(String trackId, LyricData lyric);
}
