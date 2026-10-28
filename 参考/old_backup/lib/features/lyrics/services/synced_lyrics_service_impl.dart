import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/models/lyrics_model.dart';
import 'package:pyro_music/features/lyrics/services/lyrics_service_impl.dart';

/// 同步歌词服务实现
class SyncedLyricsServiceImpl extends LyricsServiceImpl {
  /// 构造函数
  SyncedLyricsServiceImpl(super.isar);

  /// 获取当前播放位置对应的歌词行索引
  int getCurrentLyricIndex(LyricsInterface lyrics, int position) {
    if (!lyrics.isSynced || lyrics.syncedLyrics.isEmpty) return -1;

    final syncedLyrics = lyrics.syncedLyrics;

    // 找到当前时间对应的歌词行
    for (int i = syncedLyrics.length - 1; i >= 0; i--) {
      if (position >= syncedLyrics[i][0]) {
        return i;
      }
    }

    return -1;
  }

  /// 获取下一行歌词的时间戳
  int getNextLyricTimestamp(LyricsInterface lyrics, int currentIndex) {
    if (!lyrics.isSynced ||
        lyrics.syncedLyrics.isEmpty ||
        currentIndex < 0 ||
        currentIndex >= lyrics.syncedLyrics.length - 1) {
      return -1;
    }

    return lyrics.syncedLyrics[currentIndex + 1][0];
  }

  /// 调整同步歌词时间戳
  Future<LyricsInterface?> adjustSyncedLyrics(
      LyricsInterface lyrics, int index, int newTimestamp) async {
    if (!lyrics.isSynced ||
        lyrics.syncedLyrics.isEmpty ||
        index < 0 ||
        index >= lyrics.syncedLyrics.length) {
      return null;
    }

    try {
      // 创建新的同步歌词列表
      final List<List<dynamic>> newSyncedLyrics =
          List.from(lyrics.syncedLyrics);
      newSyncedLyrics[index][0] = newTimestamp;

      // 创建更新后的歌词对象
      final updatedLyrics = LyricsModel(
        id: lyrics.id,
        track: lyrics.track,
        text: lyrics.text,
        isSynced: true,
        syncedLyrics: newSyncedLyrics,
        language: lyrics.language,
        source: lyrics.source,
      );

      // 保存到数据库
      await saveLyrics(updatedLyrics);

      return updatedLyrics;
    } catch (e) {
      print('调整同步歌词时间戳失败: $e');
      return null;
    }
  }

  /// 导出LRC格式歌词
  String exportToLRC(LyricsInterface lyrics) {
    if (!lyrics.isSynced || lyrics.syncedLyrics.isEmpty) {
      return lyrics.text;
    }

    final buffer = StringBuffer();

    // 添加LRC头信息
    buffer.writeln('[ti:${lyrics.track.name}]');
    if (lyrics.track.artistNames.isNotEmpty) {
      buffer.writeln('[ar:${lyrics.track.artistNames.first}]');
    }
    if (lyrics.track.albumName != null) {
      buffer.writeln('[al:${lyrics.track.albumName}]');
    }
    buffer.writeln('[by:Pyro Music]');
    if (lyrics.language != null) {
      buffer.writeln('[lang:${lyrics.language}]');
    }

    // 添加时间戳歌词
    for (var line in lyrics.syncedLyrics) {
      final timestamp = line[0] as int;
      final text = line[1] as String;

      // 转换时间戳为LRC格式 [mm:ss.xx]
      final minutes = (timestamp ~/ 60000).toString().padLeft(2, '0');
      final seconds = ((timestamp % 60000) ~/ 1000).toString().padLeft(2, '0');
      final milliseconds =
          ((timestamp % 1000) ~/ 10).toString().padLeft(2, '0');

      buffer.writeln('[$minutes:$seconds.$milliseconds]$text');
    }

    return buffer.toString();
  }

  /// 从LRC格式导入同步歌词
  Future<LyricsInterface?> importFromLRC(
      String lrcContent, TrackInterface track) async {
    try {
      final lines = lrcContent.split('\n');
      final syncedLyrics = <List<dynamic>>[];
      String plainText = '';

      for (var line in lines) {
        // 解析LRC时间戳 [mm:ss.xx]
        final regex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2})\](.*)$');
        final match = regex.firstMatch(line);

        if (match != null) {
          final minutes = int.parse(match.group(1)!);
          final seconds = int.parse(match.group(2)!);
          final milliseconds = int.parse(match.group(3)!) * 10;
          final text = match.group(4)!.trim();

          final timestamp = minutes * 60000 + seconds * 1000 + milliseconds;
          syncedLyrics.add([timestamp, text]);
          plainText += '$text\n';
        }
      }

      if (syncedLyrics.isEmpty) {
        return null;
      }

      // 创建同步歌词对象
      final lyrics = LyricsModel(
        id: '${track.id}_lrc_import',
        track: track,
        text: plainText.trim(),
        isSynced: true,
        syncedLyrics: syncedLyrics,
        language: null,
        source: 'lrc_import',
      );

      // 保存到数据库
      await saveLyrics(lyrics);

      return lyrics;
    } catch (e) {
      print('从LRC导入同步歌词失败: $e');
      return null;
    }
  }
}
