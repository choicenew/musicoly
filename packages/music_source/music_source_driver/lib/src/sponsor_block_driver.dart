import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// SponsorBlock Segment Category
enum SponsorSegmentCategory {
  sponsor('sponsor', '赞助商广告'),
  intro('intro', '片头无声/开场'),
  outro('outro', '片尾结束语'),
  musicOfftopic('music_offtopic', '非音乐闲聊片段'),
  preview('preview', '下期预告');

  final String key;
  final String label;
  const SponsorSegmentCategory(this.key, this.label);
}

class SponsorSegment {
  final Duration start;
  final Duration end;
  final SponsorSegmentCategory category;

  const SponsorSegment({
    required this.start,
    required this.end,
    required this.category,
  });

  bool contains(Duration position) {
    return position >= start && position < end;
  }
}

/// InnerTune & OuterTune Inspired Production SponsorBlock Client
class SponsorBlockDriver {
  static const String _apiBaseUrl = 'https://sponsor.ajay.app/api/skipSegments';
  final Map<String, List<SponsorSegment>> _segmentCache = {};

  /// 从 SponsorBlock 官方 API 拉取指定视频/曲目的跳过片段
  Future<List<SponsorSegment>> fetchSkipSegments(String videoId) async {
    if (videoId.isEmpty) return [];
    if (_segmentCache.containsKey(videoId)) {
      return _segmentCache[videoId]!;
    }

    try {
      final uri = Uri.parse('$_apiBaseUrl?videoID=$videoId&categories=["sponsor","intro","outro","music_offtopic"]');
      final response = await http.get(uri).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final segments = <SponsorSegment>[];

        for (var item in jsonList) {
          final List<dynamic> segmentRange = item['segment'];
          final String categoryKey = item['category'];

          if (segmentRange.length >= 2) {
            final startSec = (segmentRange[0] as num).toDouble();
            final endSec = (segmentRange[1] as num).toDouble();

            final category = SponsorSegmentCategory.values.firstWhere(
              (c) => c.key == categoryKey,
              orElse: () => SponsorSegmentCategory.sponsor,
            );

            segments.add(SponsorSegment(
              start: Duration(milliseconds: (startSec * 1000).toInt()),
              end: Duration(milliseconds: (endSec * 1000).toInt()),
              category: category,
            ));
          }
        }

        _segmentCache[videoId] = segments;
        debugPrint('Fetched ${segments.length} SponsorBlock segments for $videoId');
        return segments;
      }
    } catch (e) {
      debugPrint('SponsorBlock API fetch error: $e');
    }

    _segmentCache[videoId] = [];
    return [];
  }

  /// 检查当前播放位置是否触发智能跳过，并返回应跳转的目标时间
  Duration? checkShouldSkip(String videoId, Duration currentPosition) {
    final segments = _segmentCache[videoId];
    if (segments == null || segments.isEmpty) return null;

    for (var segment in segments) {
      if (segment.contains(currentPosition)) {
        debugPrint('SponsorBlock triggered! Skipping ${segment.category.label} from ${segment.start} to ${segment.end}');
        return segment.end;
      }
    }
    return null;
  }
}
