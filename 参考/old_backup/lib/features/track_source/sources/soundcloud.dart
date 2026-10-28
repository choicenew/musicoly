import 'package:soundcloud_explode_dart/soundcloud_explode_dart.dart'
    as soundcloud;
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';

/// SoundCloud音源客户端
final soundcloudClient = soundcloud.SoundcloudClient();

/// SoundCloud音源实现
class SoundcloudSource {
  /// 从轨道获取音源
  static Future<SourcedTrack> fetchFromTrack({
    required TrackInterface track,
  }) async {
    final searchQuery = "${track.name} ${track.artistNames.join(' ')}";

    try {
      // 修复: 使用正确的搜索方法
      final searchResults = await soundcloudClient.search.getTracks(searchQuery).first;
      
      if (searchResults.isEmpty) {
        throw Exception('未找到匹配的SoundCloud曲目');
      }

      final trackResult = searchResults.first;

      final sourceInfo = SourceInfoModel(
        id: trackResult.id.toString(),
        title: trackResult.title,
        artist: trackResult.user.username,
        thumbnailUrl: trackResult.artworkUrl?.toString() ?? '', // Add explicit string conversion
        duration: Duration(milliseconds: trackResult.duration.toInt()), // Convert double to int
        source: AudioSource.soundcloud,
      );

      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: AudioSource.soundcloud,
        codec: SourceCodecs.m4a,
      );
    } catch (e) {
      throw Exception('获取SoundCloud音源失败: $e');
    }
  }

  /// 搜索SoundCloud曲目
  static Future<List<SourceInfo>> search(String query) async {
    try {
      final results = await soundcloudClient.search.getTracks(query).first;
      
      return results
          .map((track) => SourceInfoModel(
                id: track.id.toString(),
                title: track.title,
                artist: track.user.username,
                thumbnailUrl: track.artworkUrl?.toString() ?? '', // Convert Uri to String
                duration: Duration(milliseconds: track.duration.toInt()), // Convert double to int
                source: AudioSource.soundcloud,
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
