import '../entities/lyric_line_entity.dart';

abstract class LyricSourceDriver {
  String get providerId;
  String get providerName;
  Future<List<LyricLineEntity>> fetchLyrics(String trackId, {String? trackName, String? artistName});
}
