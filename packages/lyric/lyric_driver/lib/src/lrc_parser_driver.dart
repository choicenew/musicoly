import 'package:lyric_protocol/lyric_protocol.dart';

class LrcParserDriver implements LyricSourceDriver {
  @override
  String get providerId => 'lrc_parser';

  @override
  String get providerName => 'Local LRC & TTML Parser Driver';

  @override
  Future<List<LyricLineEntity>> fetchLyrics(String trackId, {String? trackName, String? artistName}) async {
    return [
      LyricLineEntity(
        startTime: const Duration(seconds: 0),
        text: '$trackName - $artistName',
      ),
    ];
  }
}
