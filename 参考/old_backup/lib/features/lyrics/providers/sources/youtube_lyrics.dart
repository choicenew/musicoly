import 'package:dio/dio.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/services/logger/logger.dart';
import 'package:uuid/uuid.dart';

/// YouTube Music歌词提供者
/// 负责从YouTube Music获取歌词
class YoutubeMusicLyricsProvider {
  final TrackInterface track;
  final Dio dio;

  const YoutubeMusicLyricsProvider(this.track, this.dio);

  /// 获取歌词
  Future<LyricsInterface?> getLyrics() async {
    try {
      final response = await dio.post(
        'https://music.youtube.com/youtubei/v1/browse',
        data: {
          'context': {
            'client': {'clientName': 'WEB_REMIX'}
          },
          'browseId': 'MPLAR${track.id}',
        },
      );

      if (response.statusCode != 200) {
        return _createEmptyLyrics(response.realUri.toString());
      }

      final data = response.data;
      final lyrics = data['lyrics']?['lyrics']?['runs'] as List?;

      if (lyrics == null || lyrics.isEmpty) {
        return null;
      }

      final List<List<dynamic>> syncedLyrics = [];
      Duration currentTime = Duration.zero;
      final StringBuffer textBuffer = StringBuffer();

      for (final line in lyrics) {
        if (line['startTimeMs'] != null) {
          currentTime = Duration(milliseconds: line['startTimeMs']);
        }

        final text = line['text'] as String;
        syncedLyrics.add([currentTime.inMilliseconds, text]);

        if (textBuffer.isNotEmpty) {
          textBuffer.write('\n');
        }
        textBuffer.write(text);
      }

      return _YoutubeMusicLyrics(
        track: track,
        text: textBuffer.toString(),
        syncedLyrics: syncedLyrics,
        source: "YouTube Music",
        isSynced: syncedLyrics.isNotEmpty,
      );
    } catch (e, stack) {
      AppLogger.error('YouTube Music lyrics fetch failed', e, stack);
      return null;
    }
  }

  /// 创建空歌词
  LyricsInterface _createEmptyLyrics(String uri) {
    return _YoutubeMusicLyrics(
      track: track,
      text: "",
      syncedLyrics: [],
      source: "YouTube Music",
      isSynced: false,
    );
  }
}

/// YouTube Music歌词实现
class _YoutubeMusicLyrics implements LyricsInterface {
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
  String get id => "${track.id}_youtubemusic_${_uuid.v4()}";

  @override
  String? get language => null;

  const _YoutubeMusicLyrics({
    required this.track,
    required this.text,
    required this.syncedLyrics,
    required this.source,
    required this.isSynced,
  });
}
