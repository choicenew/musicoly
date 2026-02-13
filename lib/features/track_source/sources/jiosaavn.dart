import 'package:jiosaavn/jiosaavn.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';

/// JioSaavn音源客户端
final jiosaavnClient = JioSaavnClient();

/// JioSaavn音源实现
class JioSaavnSource {
  /// 从轨道获取音源
  static Future<SourcedTrack> fetchFromTrack({
    required TrackInterface track,
  }) async {
    // 构建搜索查询
    final searchQuery = "${track.name} ${track.artistNames.join(' ')}";

    try {
      // 搜索歌曲
      final searchResults =
          await jiosaavnClient.search.songs(searchQuery.trim());

      // 如果没有找到结果，抛出异常
      if (searchResults.results.isEmpty) {
        throw Exception('未找到匹配的JioSaavn歌曲');
      }

      // 获取第一个结果
      final song = searchResults.results.first;

      // 创建源信息模型
      final sourceInfo = SourceInfoModel(
        id: song.id,
        title: song.name ?? '',
        artist: song.primaryArtists,
        thumbnailUrl: song.image?.first?.link ?? '',
        duration: Duration(seconds: int.tryParse(song.duration) ?? 0),
        source: AudioSource.jiosaavn,
      );

      // 创建源轨道模型
      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: AudioSource.jiosaavn,
        codec: SourceCodecs.m4a,
      );
    } catch (e) {
      // 处理异常
      throw Exception('获取JioSaavn音源失败: $e');
    }
  }

  /// 搜索JioSaavn歌曲
  static Future<List<SourceInfo>> search(String query) async {
    try {
      // 搜索歌曲
      final searchResults = await jiosaavnClient.search.songs(query.trim());

      // 转换为SourceInfo列表
      return searchResults.results
          .map((song) => SourceInfoModel(
                id: song.id,
                title: song.name ?? '',
                artist: song.primaryArtists,
                thumbnailUrl: song.image?.first?.link ?? '',
                duration: Duration(seconds: int.tryParse(song.duration) ?? 0),
                source: AudioSource.jiosaavn,
              ))
          .toList();
    } catch (e) {
      // 处理异常
      return [];
    }
  }
}
