import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/services/lyrics_service.dart';
import 'base_provider.dart';

/// Mixin for lyrics services
mixin LyricsProviderMixin on BaseProviderMixin<LyricsService> {
  /// 加载歌词
  Future<LyricsInterface?> loadLyrics(TrackInterface track) async {
    try {
      return await service.getLyrics(track);
    } catch (e) {
      return null;
    }
  }

  /// 加载同步歌词
  Future<LyricsInterface?> loadSyncedLyrics(TrackInterface track) async {
    try {
      final lyrics = await service.getSyncedLyrics(track);
      return lyrics;
    } catch (e) {
      return null;
    }
  }

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    try {
      return await service.searchLyrics(query,
          limit: limit, offset: offset);
    } catch (e) {
      return [];
    }
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    try {
      return await service.saveLyrics(lyrics);
    } catch (e) {
      return false;
    }
  }
}

