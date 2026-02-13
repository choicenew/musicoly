import 'package:piped_client/piped_client.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';
import 'package:pyro_music/features/track_source/exceptions/track_source_exceptions.dart';

/// Piped音源客户端
final pipedClient = PipedClient(instance: "https://pipedapi.kavin.rocks");

/// Piped音源实现
class PipedSource {
  /// 从轨道获取音源
  static Future<SourcedTrack> fetchFromTrack({
    required TrackInterface track,
    String? pipedInstance,
  }) async {
    final client = pipedInstance != null
        ? PipedClient(instance: pipedInstance)
        : pipedClient;

    final searchQuery = "${track.name} ${track.artistNames.join(' ')}";

    try {
      final searchResults = await client.search(searchQuery);

      // 只处理类型为 stream 的结果
      final videoItems = searchResults.items
          .whereType<PipedSearchItemStream>()
          .toList();

      if (videoItems.isEmpty) {
        throw TrackNotFoundError(track, '未找到匹配的Piped视频');
      }

      final video = videoItems.first;

      final sourceInfo = SourceInfoModel(
        id: video.url,
        title: video.title,
        artist: video.uploaderName,
        thumbnailUrl: video.thumbnail,
        duration: _parseDuration(video.duration),
        source: AudioSource.piped,
      );

      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: AudioSource.piped,
        codec: SourceCodecs.opus,
      );
    } catch (e) {
      if (e is TrackNotFoundError) throw e;
      throw SourceFetchError(track, 'Piped', e.toString());
    }
  }

  /// 搜索Piped视频
  static Future<List<SourceInfo>> search(String query,
      {String? pipedInstance}) async {
    try {
      final client = pipedInstance != null
          ? PipedClient(instance: pipedInstance)
          : pipedClient;

      final searchResults = await client.search(query);

      return searchResults.items
          .whereType<PipedSearchItemStream>()
          .map((video) => SourceInfoModel(
                id: video.url,
                title: video.title,
                artist: video.uploaderName,
                thumbnailUrl: video.thumbnail,
                duration: _parseDuration(video.duration),
                source: AudioSource.piped,
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Duration _parseDuration(Duration duration) => duration;
}
