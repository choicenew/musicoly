import 'package:dio/dio.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/services/logger/logger.dart';
import 'package:uuid/uuid.dart';

/// Petit Lyrics歌词提供者
/// 负责从Petit Lyrics获取歌词
class PetitLyricsProvider {
  final TrackInterface track;
  final Dio dio;

  const PetitLyricsProvider(this.track, this.dio);

  /// 解析Petit Lyrics HTML
  String _parsePetitLyricsHtml(String html) {
    const resultStart = "<a href=\"lyrics/";
    const resultEnd = "</a>";

    final startIndex = html.indexOf(resultStart);
    if (startIndex == -1) return '';

    final endIndex = html.indexOf(resultEnd, startIndex);
    if (endIndex == -1) return '';

    return html.substring(startIndex + resultStart.length, endIndex);
  }

  /// 获取歌词
  Future<LyricsInterface?> getLyrics() async {
    try {
      final res = await dio.getUri(
        Uri.parse("https://petitlyrics.com/search_lyrics").replace(
          queryParameters: {
            "title": track.name,
            "artist": track.artistNames.join(", "),
          },
        ),
        options: Options(
          headers: {
            "User-Agent":
                "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/114.0"
          },
          validateStatus: (status) => true,
        ),
      );

      if (res.statusCode != 200) {
        return _createEmptyLyrics(res.realUri.toString());
      }

      final html = res.data as String;
      final lyrics = _parsePetitLyricsHtml(html);

      if (lyrics.isEmpty) {
        return null;
      }

      return _PetitLyrics(
        track: track,
        text: lyrics,
        syncedLyrics: [],
        source: "PetitLyrics",
        isSynced: false,
      );
    } catch (e, stack) {
      AppLogger.error('PetitLyrics fetch failed', e, stack);
      return null;
    }
  }

  /// 创建空歌词
  LyricsInterface _createEmptyLyrics(String uri) {
    return _PetitLyrics(
      track: track,
      text: "",
      syncedLyrics: [],
      source: "PetitLyrics",
      isSynced: false,
    );
  }
}

/// Petit Lyrics歌词实现
class _PetitLyrics implements LyricsInterface {
  final Uuid _uuid = const Uuid();

  @override
  final TrackInterface track;

  @override
  final String text;

  @override
  final List<List<dynamic>> syncedLyrics;

  @override
  final String? source;

  @override
  final bool isSynced;

  @override
  String get id => "${track.id}_petitlyrics_${_uuid.v4()}";

  @override
  String? get language => null;

  const _PetitLyrics({
    required this.track,
    required this.text,
    required this.syncedLyrics,
    required this.source,
    required this.isSynced,
  });
}
