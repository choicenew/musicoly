import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/track_interface.dart';
import '../models/youtube_track.dart';

/// YouTube Music音轨适配器
///
/// 负责将YouTube Music特定的音轨模型转换为应用程序通用的接口模型
@immutable
class YouTubeTrackAdapter {
  /// 将YouTubeTrack转换为TrackInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为YouTubeTrack已经实现了TrackInterface接口
  static TrackInterface toInterface(YouTubeTrack track) {
    return track;
  }

  /// 将TrackInterface转换为YouTubeTrack
  ///
  /// 如果传入的track已经是YouTubeTrack类型，则直接返回
  /// 否则，创建一个新的YouTubeTrack实例
  static YouTubeTrack fromInterface(TrackInterface track) {
    if (track is YouTubeTrack) {
      return track;
    }

    return YouTubeTrack(
      id: track.id,
      name: track.name,
      artistIds: track.artistIds,
      artistNames: track.artistNames,
      albumId: track.albumId,
      albumName: track.albumName,
      durationMs: track.durationMs,
      isPlayable: track.isPlayable,
      trackNumber: track.trackNumber,
      discNumber: track.discNumber,
      popularity: track.popularity,
      isExplicit: track.isExplicit,
      previewUrl: track.previewUrl,
      imageUrl: track.imageUrl,
      platformMetadata: track.platformMetadata,
    );
  }
}
