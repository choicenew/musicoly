import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/track_interface.dart';
import '../models/spotify_track.dart';

/// Spotify音轨适配器
///
/// 负责将Spotify特定的音轨模型转换为应用程序通用的接口模型
@immutable
class SpotifyTrackAdapter {
  /// 将SpotifyTrack转换为TrackInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为SpotifyTrack已经实现了TrackInterface接口
  static TrackInterface toInterface(SpotifyTrack track) {
    return track;
  }

  /// 将TrackInterface转换为SpotifyTrack
  ///
  /// 如果传入的track已经是SpotifyTrack类型，则直接返回
  /// 否则，创建一个新的SpotifyTrack实例
  static SpotifyTrack fromInterface(TrackInterface track) {
    if (track is SpotifyTrack) {
      return track;
    }

    return SpotifyTrack(
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
