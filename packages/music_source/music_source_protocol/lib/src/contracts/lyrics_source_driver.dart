import '../entities/lyrics_entity.dart';

abstract class LyricsSourceDriver {
  String get platformId;
  Future<LyricsEntity?> getLyrics(String trackId, {String? trackName, String? artistName});
}
