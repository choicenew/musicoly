import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/core/storage/isar/entities/index.dart';
import 'package:pyro_music/features/lyric/utils/lrc_parser.dart';

/// 本地歌词插件 - 负责从本地数据库和文件系统读取/缓存歌词
class LocalLyricPlugin extends LyricPlugin {
  final Isar _isar;

  LocalLyricPlugin(this._isar);

  @override
  String get pluginId => 'local';

  @override
  String get serviceId => 'lyric_local';

  @override
  String get serviceName => '本地歌词';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {}

  @override
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0}) async {
    // 本地搜索可以从 Isar 中搜索已保存的歌词
    try {
      final results = await _isar.lyricsEntitys
          .filter()
          .trackIdContains(query, caseSensitive: false)
          .findAll();

      final List<LyricData> lyrics = [];
      for (final entity in results) {
        if (entity.filePath != null) {
          final file = File(entity.filePath!);
          if (await file.exists()) {
            final content = await file.readAsString();
            lyrics.add(LocalLyricData(
              lines: LrcParser.parse(content),
              sourceId: pluginId,
              trackName: entity.trackId ?? 'Unknown',
              artistNames: 'Local',
              metadata: {'language': entity.language},
              isSynced: entity.isSynced,
            ));
          }
        }
      }
      return lyrics;
    } catch (e) {
      debugPrint('本地歌词搜索失败: $e');
      return [];
    }
  }

  @override
  Future<LyricData?> fetchLyric(String trackId,
      {Map<String, dynamic>? metadata}) async {
    try {
      // 1. 从 Isar 查找记录
      final lyricsEntity = await _isar.lyricsEntitys
          .filter()
          .trackIdEqualTo(trackId)
          .findFirst();

      if (lyricsEntity != null && lyricsEntity.filePath != null) {
        // 2. 从文件读取歌词内容
        final file = File(lyricsEntity.filePath!);
        if (await file.exists()) {
          final content = await file.readAsString();
          final lines = LrcParser.parse(content);
          
          return LocalLyricData(
            lines: lines,
            sourceId: 'local',
            trackName: metadata?['trackName'] ?? 'Unknown Track',
            artistNames: metadata?['artistNames'] ?? 'Unknown Artist',
            isSynced: lyricsEntity.isSynced,
            metadata: {
              'language': lyricsEntity.language,
              'isSynced': lyricsEntity.isSynced,
            },
          );
        }
      }
    } catch (e) {
      debugPrint('本地歌词获取失败: $e');
    }
    return null;
  }

  @override
  Future<bool> saveLyric(String trackId, LyricData lyric) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final lyricsDir = Directory('${dir.path}/lyrics');
      if (!await lyricsDir.exists()) {
        await lyricsDir.create(recursive: true);
      }

      final filePath = '${lyricsDir.path}/$trackId.lrc';
      
      // 将 LyricData 转换为 LRC 格式字符串
      final buffer = StringBuffer();
      for (final line in lyric.lines) {
        final minutes = line.startTime.inMinutes.toString().padLeft(2, '0');
        final seconds = (line.startTime.inSeconds % 60).toString().padLeft(2, '0');
        final milliseconds = (line.startTime.inMilliseconds % 1000).toString().padLeft(3, '0').substring(0, 2);
        buffer.writeln('[$minutes:$seconds.$milliseconds]${line.text}');
      }
      
      final content = buffer.toString();
      await File(filePath).writeAsString(content);

      final entity = LyricsEntity()
        ..lyricsId = 'local_$trackId'
        ..trackId = trackId
        ..filePath = filePath
        ..content = content
        ..isSynced = lyric.isSynced
        ..source = 'cached';

      await _isar.writeTxn(() async {
        await _isar.lyricsEntitys.put(entity);
      });
      return true;
    } catch (e) {
      debugPrint('本地歌词保存失败: $e');
      return false;
    }
  }
}

class LocalLyricData implements LyricData {
  @override
  final List<LyricLine> lines;
  @override
  final String sourceId;
  @override
  final String trackName;
  @override
  final String artistNames;
  @override
  final Map<String, dynamic> metadata;
  @override
  final bool isSynced;

  LocalLyricData({
    required this.lines,
    required this.sourceId,
    required this.trackName,
    required this.artistNames,
    required this.metadata,
    this.isSynced = true,
  });
}
