import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lyric_protocol/lyric_protocol.dart';

/// LRCLIB Online Synchronized Lyrics API Client Driver (InnerTune & Musify Inspired)
class LrcLibClientDriver implements LyricSourceDriver {
  final Dio _dio = Dio();

  @override
  String get providerId => 'lrclib_online';

  @override
  String get providerName => 'LRCLIB Synchronized Lyrics Online Driver';

  @override
  Future<List<LyricLineEntity>> fetchLyrics(String trackId, {String? trackName, String? artistName}) async {
    if (trackName == null || artistName == null) return [];
    try {
      final response = await _dio.get(
        'https://lrclib.net/api/get',
        queryParameters: {
          'track_name': trackName,
          'artist_name': artistName,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final syncedLyrics = response.data['syncedLyrics'] as String?;
        if (syncedLyrics != null && syncedLyrics.isNotEmpty) {
          return _parseLrc(syncedLyrics);
        }
      }
    } catch (e) {
      debugPrint('Error fetching lyrics from LRCLIB: $e');
    }
    return [
      LyricLineEntity(startTime: Duration.zero, text: 'No online synced lyrics found for $trackName')
    ];
  }

  List<LyricLineEntity> _parseLrc(String lrcContent) {
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
