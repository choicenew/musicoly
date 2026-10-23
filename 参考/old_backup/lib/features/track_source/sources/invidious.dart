import 'package:invidious/invidious.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';
import 'package:pyro_music/features/track_source/exceptions/track_source_exceptions.dart';

/// Invidious音源客户端
final invidiousClient = InvidiousClient(server: "https://invidious.io");

/// Invidious音源实现
class InvidiousSource {
  /// 从轨道获取音源
  static Future<SourcedTrack> fetchFromTrack({
    required TrackInterface track,
    String? invidiousInstance,
  }) async {
    // 如果提供了实例URL，则使用它
    final client = invidiousInstance != null
        ? InvidiousClient(server: invidiousInstance)
        : invidiousClient;

    // 构建搜索查询
    final searchQuery = "${track.name} ${track.artistNames.join(' ')}";

    try {
      // 搜索视频
      final searchResults = await client.search.list(
        searchQuery,
        type: InvidiousSearchType.video,
      );

      // 如果没有找到结果，抛出轨道未找到异常
      if (searchResults.isEmpty) {
        throw TrackNotFoundError(track, '未找到匹配的Invidious视频');
      }

      // 获取第一个结果并转换为视频类型
      final video = searchResults.first as InvidiousSearchResponseVideo;

      // 创建源信息模型
      final sourceInfo = SourceInfoModel(
        id: video.videoId,
        title: video.title,
        artist: video.author,
        thumbnailUrl: video.videoThumbnails.first.url,
        duration: Duration(seconds: video.lengthSeconds),
        source: AudioSource.invidious,
      );

      // 创建源轨道模型
      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: AudioSource.invidious,
        codec: SourceCodecs.opus,
      );
    } catch (e) {
      // 处理异常
      if (e is TrackNotFoundError) {
        throw e;
      }
      throw SourceFetchError(track, 'Invidious', e.toString());
    }
  }

  /// 搜索Invidious视频
  static Future<List<SourceInfo>> search(String query,
      {String? invidiousInstance}) async {
    try {
      // 如果提供了实例URL，则使用它
      final client = invidiousInstance != null
          ? InvidiousClient(server: invidiousInstance)
          : invidiousClient;

      // 搜索视频
      final searchResults = await client.search.list(
        query,
        type: InvidiousSearchType.video,
      );

      // 转换为SourceInfo列表，确保只处理视频类型的结果
      return searchResults
          .whereType<InvidiousSearchResponseVideo>()
          .map((video) => SourceInfoModel(
                id: video.videoId,
                title: video.title,
                artist: video.author,
                thumbnailUrl: video.videoThumbnails.first.url,
                duration: Duration(seconds: video.lengthSeconds),
                source: AudioSource.invidious,
              ))
          .toList();
    } catch (e) {
      // 处理异常
      return [];
    }
  }
}
