import 'dart:io';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/base/services/lyrics_service.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/models/lyrics_model.dart';
import 'package:pyro_music/core/storage/isar/entities/index.dart';
import 'package:pyro_music/services/logger/logger.dart';
import 'package:uuid/uuid.dart';

/// 歌词服务实现
class LyricsServiceImpl implements LyricsService {
  @override
  String get serviceId => 'lyrics_service';

  @override
  String get serviceName => 'Lyrics Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> dispose() async {}

  @override
  Map<String, dynamic> getConfig() => {};

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {}

  @override
  List<Type> getDependencies() => [Isar];

  @override
  ServiceStatus getStatus() => ServiceStatus.available;

  final Isar _isar;
  final Uuid _uuid = const Uuid();

  /// 构造函数
  LyricsServiceImpl(this._isar);

  Future<String> _getLyricsDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final lyricsDir = Directory('${dir.path}/lyrics');
    if (!await lyricsDir.exists()) {
      await lyricsDir.create(recursive: true);
    }
    return lyricsDir.path;
  }

  Future<String?> _readLyricsFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      AppLogger.error('读取歌词文件失败: $filePath', e);
    }
    return null;
  }

  Future<String> _saveLyricsFile(String id, String content) async {
    final dir = await _getLyricsDir();
    final file = File('$dir/$id.lrc');
    await file.writeAsString(content);
    return file.path;
  }

  @override
  Future<LyricsInterface?> getLyrics(TrackInterface track) async {
    try {
      final lyricsEntity = await _isar.lyricsEntitys
          .filter()
          .trackIdEqualTo(track.id)
          .findFirst();

      if (lyricsEntity != null && lyricsEntity.filePath != null) {
        final text = await _readLyricsFile(lyricsEntity.filePath!);
        if (text != null) {
          return LyricsModel(
            id: lyricsEntity.lyricsId,
            track: track,
            text: text,
            isSynced: lyricsEntity.isSynced,
            language: lyricsEntity.language,
            source: lyricsEntity.source,
          );
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('获取歌词失败', e);
      return null;
    }
  }

  @override
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    // 简单实现，Isar 搜索需要更复杂的配置或者 FTS
    // 这里暂时不做实现，因为之前的实现依赖 TrackDao 联表查询
    return [];
  }

  @override
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    try {
      final filePath = await _saveLyricsFile(lyrics.id, lyrics.text);

      final entity = LyricsEntity()
        ..lyricsId = lyrics.id
        ..trackId = lyrics.track.id
        ..filePath = filePath
        ..isSynced = lyrics.isSynced
        ..language = lyrics.language
        ..source = lyrics.source
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      await _isar.writeTxn(() async {
        await _isar.lyricsEntitys.putByLyricsId(entity);
      });
      return true;
    } catch (e) {
      AppLogger.error('保存歌词失败', e);
      return false;
    }
  }

  @override
  Future<LyricsInterface?> getSyncedLyrics(TrackInterface track) async {
    try {
      final lyricsEntity = await _isar.lyricsEntitys
          .filter()
          .trackIdEqualTo(track.id)
          .and()
          .isSyncedEqualTo(true)
          .findFirst();

      if (lyricsEntity != null && lyricsEntity.filePath != null) {
        final text = await _readLyricsFile(lyricsEntity.filePath!);
        if (text != null) {
          return LyricsModel(
            id: lyricsEntity.lyricsId,
            track: track,
            text: text,
            isSynced: true,
            syncedLyrics: _parseSyncedLyricsFromText(text),
            language: lyricsEntity.language,
            source: lyricsEntity.source,
          );
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('获取同步歌词失败', e);
      return null;
    }
  }

  List<List<dynamic>> _parseSyncedLyricsFromText(String text) {
    final List<List<dynamic>> result = [];
    final lines = text.split('\n');
    final timeRegex = RegExp(r'\[(\d+):(\d+)\.(\d+)\]');

    for (var line in lines) {
      final match = timeRegex.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final milliseconds = int.parse(match.group(3)!.padRight(3, '0'));
        final timestamp = minutes * 60 * 1000 + seconds * 1000 + milliseconds;
        final lyricText = line.substring(match.end).trim();
        result.add([timestamp, lyricText]);
      }
    }
    return result;
  }

  @override
  Future<LyricsInterface?> convertToSyncedLyrics(LyricsInterface lyrics) async {
    try {
      if (lyrics.isSynced) return lyrics;

      final timeRegex = RegExp(r'\[(\d+):(\d+)\.(\d+)\]');
      if (!timeRegex.hasMatch(lyrics.text)) return null;

      final syncedLyrics = _parseSyncedLyricsFromText(lyrics.text);
      if (syncedLyrics.isEmpty) return null;

      final syncedLyricsModel = LyricsModel(
        id: '${lyrics.id}_synced',
        track: lyrics.track,
        text: lyrics.text,
        isSynced: true,
        syncedLyrics: syncedLyrics,
        language: lyrics.language,
        source: lyrics.source,
      );

      await saveLyrics(syncedLyricsModel);
      return syncedLyricsModel;
    } catch (e) {
      AppLogger.error('转换为同步歌词失败', e);
      return null;
    }
  }
}
