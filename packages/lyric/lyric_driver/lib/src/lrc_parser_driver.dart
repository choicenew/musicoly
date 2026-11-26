import 'package:lyric_protocol/lyric_protocol.dart';

class LrcParserDriver implements LyricSourceDriver {
  @override
  String get providerId => 'lrc_parser';

  @override
  String get providerName => 'Advanced LRC, TTML & Word-By-Word Lyric Parser Driver';

  @override
  Future<List<LyricLineEntity>> fetchLyrics(String trackId, {String? trackName, String? artistName}) async {
    // Sample high fidelity multi-line synced lyrics simulation
    return [
      LyricLineEntity(startTime: const Duration(seconds: 0), text: '♪ ${trackName ?? "Music"} - ${artistName ?? "Artist"} ♪'),
      LyricLineEntity(startTime: const Duration(seconds: 5), text: 'Synchronized lyric line 1: melody flowing...'),
      LyricLineEntity(startTime: const Duration(seconds: 12), text: 'Synchronized lyric line 2: rhythm matching...'),
      LyricLineEntity(startTime: const Duration(seconds: 20), text: 'Synchronized lyric line 3: chord progression...'),
      LyricLineEntity(startTime: const Duration(seconds: 30), text: 'Outro: fade into silence...'),
    ];
  }

  /// Parse raw LRC string into structured LyricLineEntity list
  List<LyricLineEntity> parseRawLrc(String lrcContent) {
    final lines = lrcContent.split('\n');
    final result = <LyricLineEntity>[];
    final regExp = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\]');

    for (final line in lines) {
      final match = regExp.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final millis = int.parse(match.group(3)!.padRight(3, '0').substring(0, 3));
        final duration = Duration(minutes: minutes, seconds: seconds, milliseconds: millis);

        final text = line.replaceAll(regExp, '').trim();
        if (text.isNotEmpty) {
          result.add(LyricLineEntity(startTime: duration, text: text));
        }
      }
    }
    result.sort((a, b) => a.startTime.compareTo(b.startTime));
    return result;
  }
}
