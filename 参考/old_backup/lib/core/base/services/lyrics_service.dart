import 'package:pyro_music/core/base/services/base_service.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';

/// 歌词服务接口
abstract class LyricsService extends BaseService {
  /// 获取曲目歌词
  Future<LyricsInterface?> getLyrics(TrackInterface track);

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0});

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics);

  /// 获取同步歌词
  Future<LyricsInterface?> getSyncedLyrics(TrackInterface track);

  /// 转换为同步歌词
  Future<LyricsInterface?> convertToSyncedLyrics(LyricsInterface lyrics);
}
