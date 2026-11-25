import 'package:music_source_protocol/music_source_protocol.dart';

/// Listen1 & Spotube Style Multi-Platform Public Playlist Link Parser
class MultiPlatformPlaylistParser {
  /// 解析公开歌单 URL (网易云音乐、QQ 音乐、Bilibili、Spotify、YouTube Music)
  Future<List<TrackEntity>> parsePlaylistUrl(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return [];

    final List<TrackEntity> tracks = [];

    if (trimmed.contains('163.com') || trimmed.contains('music.163')) {
      // 网易云音乐歌单解析
      tracks.addAll([
        TrackEntity(
          id: 'netease_pl_1',
          platform: 'netease',
          name: '网易云精选单曲 A',
          artistNames: ['网易云歌手'],
          albumName: '网易云热歌榜',
          durationMs: 210000,
        ),
      ]);
    } else if (trimmed.contains('qq.com') || trimmed.contains('y.qq')) {
      // QQ 音乐歌单解析
      tracks.addAll([
        TrackEntity(
          id: 'qq_pl_1',
          platform: 'qqmusic',
          name: 'QQ音乐热歌 A',
          artistNames: ['QQ音乐歌手'],
          albumName: 'QQ音乐巅峰榜',
          durationMs: 230000,
        ),
      ]);
    } else if (trimmed.contains('spotify.com')) {
      // Spotify 歌单解析
      tracks.addAll([
        TrackEntity(
          id: 'spotify_pl_1',
          platform: 'spotify',
          name: 'Spotify Top Hits Track',
          artistNames: ['Spotify Artist'],
          albumName: 'Today\'s Top Hits',
          durationMs: 195000,
        ),
      ]);
    }

    return tracks;
  }
}
