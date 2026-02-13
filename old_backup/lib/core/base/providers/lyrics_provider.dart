import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/providers/base_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/services/lyrics_service.dart';

/// 歌词提供者
class LyricsProvider extends BaseProvider {
  final LyricsService _lyricsService;

  /// 当前歌词
  ValueNotifier<LyricsInterface?> currentLyrics = ValueNotifier(null);

  /// 是否显示同步歌词
  ValueNotifier<bool> showSyncedLyrics = ValueNotifier(true);

  /// 构造函数
  LyricsProvider(this._lyricsService);

  /// 加载歌词
  Future<LyricsInterface?> loadLyrics(TrackInterface track) async {
    try {
      final lyrics = await _lyricsService.getLyrics(track);
      if (lyrics != null) {
        currentLyrics.value = lyrics;
      }
      return lyrics;
    } catch (e) {
      debugPrint('加载歌词失败: $e');
      return null;
    }
  }

  /// 加载同步歌词
  Future<LyricsInterface?> loadSyncedLyrics(TrackInterface track) async {
    try {
      final lyrics = await _lyricsService.getSyncedLyrics(track);
      if (lyrics != null && lyrics.isSynced) {
        currentLyrics.value = lyrics;
      }
      return lyrics;
    } catch (e) {
      debugPrint('加载同步歌词失败: $e');
      return null;
    }
  }

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    try {
      return await _lyricsService.searchLyrics(query,
          limit: limit, offset: offset);
    } catch (e) {
      debugPrint('搜索歌词失败: $e');
      return [];
    }
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    try {
      return await _lyricsService.saveLyrics(lyrics);
    } catch (e) {
      debugPrint('保存歌词失败: $e');
      return false;
    }
  }

  /// 切换同步歌词显示
  void toggleSyncedLyrics() {
    showSyncedLyrics.value = !showSyncedLyrics.value;
  }

  /// 清除当前歌词
  void clearLyrics() {
    currentLyrics.value = null;
  }

  @override
  void dispose() {
    currentLyrics.dispose();
    showSyncedLyrics.dispose();
    super.dispose();
  }
}
