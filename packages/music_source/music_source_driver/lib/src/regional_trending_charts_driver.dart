import 'package:music_source_protocol/music_source_protocol.dart';

enum RegionCode {
  global('Global', '全球热歌榜'),
  us('US', '美国 Billboard 榜'),
  jp('JP', '日本 Oricon 榜'),
  cn('CN', '华语流行热歌榜'),
  uk('UK', '英国 Official 榜');

  final String code;
  final String label;
  const RegionCode(this.code, this.label);
}

/// NouTube & SimpMusic Inspired Regional Music Trending Charts Driver
class RegionalTrendingChartsDriver {
  Future<List<TrackEntity>> fetchTrendingTracks(RegionCode region) async {
    // 模拟区域热歌榜单拉取
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      TrackEntity(
        id: 'chart_${region.code}_1',
        platform: 'trending',
        name: '${region.label} Top #1 Hits Track',
        artistNames: ['Trending Artist 1'],
        albumName: region.label,
        durationMs: 205000,
      ),
      TrackEntity(
        id: 'chart_${region.code}_2',
        platform: 'trending',
        name: '${region.label} Top #2 Hits Track',
        artistNames: ['Trending Artist 2'],
        albumName: region.label,
        durationMs: 198000,
      ),
    ];
  }
}
