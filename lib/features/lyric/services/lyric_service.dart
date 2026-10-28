import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

abstract class LyricPlugin extends BaseService {
  Future<LyricData?> fetchLyric(String trackId, {Map<String, dynamic>? metadata});
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0});
}

abstract class LyricManager extends BaseService {
  List<String> get availablePlugins;
  Future<LyricData?> getLyric(String trackId, {Map<String, dynamic>? metadata});
  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0});
  Future<bool> saveLyric(String trackId, LyricData lyric);
}
