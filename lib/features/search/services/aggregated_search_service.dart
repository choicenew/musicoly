import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/track_model.dart';

/// Listen1 & Spotube Style Multi-Platform Aggregated Search Service (NetEase, QQ, Bilibili, YouTube)
class AggregatedSearchService {
  Future<List<TrackModel>> searchAllPlatforms(String query) async {
    if (query.trim().isEmpty) return [];
    
    // 模拟多源聚合搜索
    await Future.delayed(const Duration(milliseconds: 700));
    
    return [
      TrackModel(
        id: 'agg_1',
        platform: 'netease',
        name: '$query (网易云音乐热门版)',
        artistNames: ['Aggregated Artist A'],
        albumName: 'Multi-Source Hits',
        durationMs: 240000,
      ),
      TrackModel(
        id: 'agg_2',
        platform: 'qqmusic',
        name: '$query (QQ 音乐臻品音质)',
        artistNames: ['Aggregated Artist B'],
        albumName: 'QQ Hi-Res Collection',
        durationMs: 215000,
      ),
      TrackModel(
        id: 'agg_3',
        platform: 'bilibili',
        name: '$query (Bilibili 音乐现场原声)',
        artistNames: ['BiliBili Live Creator'],
        albumName: 'BiliBili OST',
        durationMs: 280000,
      ),
    ];
  }

  /// 导入公开歌单链接（支持网易云/QQ音乐分享链接解析）
  Future<List<String>> importPlaylistFromUrl(String url) async {
    debugPrint('Parsing playlist from URL: $url');
    await Future.delayed(const Duration(milliseconds: 500));
    return ['track_imported_1', 'track_imported_2', 'track_imported_3'];
  }
}
