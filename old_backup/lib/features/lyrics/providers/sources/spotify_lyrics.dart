import 'package:dio/dio.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/services/logger/logger.dart';
import 'package:uuid/uuid.dart';

/// Spotify歌词提供者
/// 负责从Spotify获取歌词
class SpotifyLyricsProvider {
  final TrackInterface track;
  final String accessToken;
  final Dio dio;

  const SpotifyLyricsProvider(this.track, this.accessToken, this.dio);

  /// 获取歌词
  Future<LyricsInterface?> getLyrics() async {
    try {
      final res = await dio.getUri(
        Uri.parse(
          "https://spclient.wg.spotify.com/color-lyrics/v2/track/${track.id}?format=json&market=from_token",
        ),
        options: Options(
          headers: {
            "User-Agent":
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.0.0 Safari/537.36",
            "App-platform": "WebPlayer",
            "authorization": "Bearer $accessToken"
          },
          responseType: ResponseType.json,
          validateStatus: (status) => true,
        ),
      );

      if (res.statusCode != 200) {
        return _createEmptyLyrics(res.realUri.toString());
      }

      final linesRaw =
          Map.castFrom<dynamic, dynamic, String, dynamic>(res.data)["lyrics"]
              ?["lines"] as List?;

      if (linesRaw == null || linesRaw.isEmpty) {
        return _createEmptyLyrics(res.realUri.toString());
      }

      final syncedLyrics = linesRaw.map((line) {
        return [int.parse(line["startTimeMs"]), line["words"] as String];
      }).toList();

      // 构建完整歌词文本
      final fullText = syncedLyrics.map((line) => line[1]).join("\n");

      return _SpotifyLyrics(
        track: track,
        text: fullText,
        syncedLyrics: syncedLyrics,
        source: "Spotify",
        isSynced: true,
      );
    } catch (e, stack) {
      AppLogger.error('Spotify lyrics fetch failed', e, stack);
      return null;
    }
  }

  /// 创建空歌词
  LyricsInterface _createEmptyLyrics(String uri) {
    return _SpotifyLyrics(
      track: track,
      text: "",
      syncedLyrics: [],
      source: "Spotify",
      isSynced: false,
    );
  }
}

/// Spotify歌词实现
class _SpotifyLyrics implements LyricsInterface {
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
  String get id => "${track.id}_spotify_${_uuid.v4()}";

  @override
  String? get language => null;

  const _SpotifyLyrics({
    required this.track,
    required this.text,
    required this.syncedLyrics,
    required this.source,
    required this.isSynced,
  });
}
