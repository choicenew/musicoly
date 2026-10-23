import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';
import 'package:pyro_music/features/track_source/exceptions/track_source_exceptions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// YouTube音源客户端
final youtubeClient = YoutubeExplode();

/// YouTube音源实现
class YouTubeSource {
  /// 从轨道获取音源
  static Future<SourcedTrack> fetchFromTrack({
    required TrackInterface track,
  }) async {
    // 构建搜索查询
    final searchQuery = "${track.name} ${track.artistNames.join(' ')}";

    try {
      // 搜索YouTube视频
      final searchResults = await youtubeClient.search.search(searchQuery);

      // 如果没有找到结果，抛出轨道未找到异常
      if (searchResults.isEmpty) {
        throw TrackNotFoundError(track, '未找到匹配的YouTube视频');
      }

      // 获取第一个结果
      final video = searchResults.first;

      // 创建源信息模型
      final sourceInfo = SourceInfoModel(
        id: video.id.value,
        title: video.title,
        artist: video.author,
        thumbnailUrl: video.thumbnails.highResUrl,
        duration: video.duration ?? Duration.zero,
        source: AudioSource.youtube,
      );

      // 创建源轨道模型
      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: AudioSource.youtube,
        codec: SourceCodecs.opus,
      );
    } catch (e) {
      // 处理异常
      if (e is TrackNotFoundError) {
        throw e;
      }
      throw SourceFetchError(track, 'YouTube', e.toString());
    }
  }

  /// 搜索YouTube视频
  static Future<List<SourceInfo>> search(String query) async {
    try {
      // 搜索YouTube视频
      final searchResults = await youtubeClient.search.search(query);

      // 转换为SourceInfo列表
      return searchResults
          .map((video) => SourceInfoModel(
                id: video.id.value,
                title: video.title,
                artist: video.author,
                thumbnailUrl: video.thumbnails.highResUrl,
                duration: video.duration ?? Duration.zero,
                source: AudioSource.youtube,
              ))
          .toList();
    } catch (e) {
      // 处理异常
      return [];
    }
  }
}
