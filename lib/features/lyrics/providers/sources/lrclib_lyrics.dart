import 'package:dio/dio.dart';
import 'package:lrc/lrc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/services/logger/logger.dart';
import 'package:uuid/uuid.dart';

/// LRCLib歌词提供者
/// 负责从LRCLib获取歌词
class LRCLibLyricsProvider {
  final Dio _dio;
  final TrackInterface track;

  const LRCLibLyricsProvider(this.track, this._dio);

  /// 获取歌词
  Future<LyricsInterface?> getLyrics() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      AppLogger.debug('Fetching lyrics from LRCLib for track: ${track.name}');

      final res = await _dio.getUri(
        Uri(
          scheme: "https",
          host: "lrclib.net",
          path: "/api/get",
          queryParameters: {
            "artist_name": track.artistNames.join(", "),
            "track_name": track.name,
            "album_name": track.albumName,
            "duration": (track.durationMs / 1000).round().toString(),
          },
        ),
        options: Options(
          headers: {"User-Agent": "Pyro Music v${packageInfo.version}"},
          responseType: ResponseType.json,
          validateStatus: (status) => true,
        ),
      );

      if (res.statusCode != 200) {
        return _createEmptyLyrics(res.realUri.toString());
      }

      final json = res.data as Map<String, dynamic>;
      final syncedLyricsRaw = json["syncedLyrics"] as String?;

      if (syncedLyricsRaw?.isNotEmpty == true) {
        final syncedLyrics = Lrc.parse(syncedLyricsRaw!).lyrics;
        final syncedLyricsFormatted = syncedLyrics
            .map((line) => [line.timestamp.inMilliseconds, line.lyrics])
            .toList();

        return _LRCLibLyrics(
          track: track,
          text: syncedLyricsRaw,
          syncedLyrics: syncedLyricsFormatted,
          source: "LRCLib",
          isSynced: true,
        );
      }

      final plainLyrics = json["plainLyrics"] as String?;
      if (plainLyrics?.isNotEmpty == true) {
        return _LRCLibLyrics(
          track: track,
          text: plainLyrics!,
          syncedLyrics: [],
          source: "LRCLib",
          isSynced: false,
        );
      }

      return null;
    } catch (e, stack) {
      AppLogger.error('LRCLib lyrics fetch failed', e, stack);
      AppLogger.warning(
          'Failed to fetch lyrics from LRCLib for track: ${track.name}');
      return null;
    }
  }

  /// 创建空歌词
  LyricsInterface _createEmptyLyrics(String uri) {
    return _LRCLibLyrics(
      track: track,
      text: "",
      syncedLyrics: [],
      source: "LRCLib",
      isSynced: false,
    );
  }
}

/// LRCLib歌词实现
class _LRCLibLyrics implements LyricsInterface {
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
  String get id => "${track.id}_lrclib_${_uuid.v4()}";

  @override
  String? get language => null;

  const _LRCLibLyrics({
    required this.track,
    required this.text,
    required this.syncedLyrics,
    required this.source,
    required this.isSynced,
  });
}
