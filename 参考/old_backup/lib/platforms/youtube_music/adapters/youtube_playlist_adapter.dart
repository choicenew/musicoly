import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/playlist_interface.dart';
import '../models/youtube_playlist.dart';

/// YouTube Music播放列表适配器
///
/// 负责将YouTube Music特定的播放列表模型转换为应用程序通用的接口模型
@immutable
class YouTubePlaylistAdapter {
  /// 将YouTubePlaylist转换为PlaylistInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为YouTubePlaylist已经实现了PlaylistInterface接口
  static PlaylistInterface toInterface(YouTubePlaylist playlist) {
    return playlist;
  }

  /// 将PlaylistInterface转换为YouTubePlaylist
  ///
  /// 如果传入的playlist已经是YouTubePlaylist类型，则直接返回
  /// 否则，创建一个新的YouTubePlaylist实例
  static YouTubePlaylist fromInterface(PlaylistInterface playlist) {
    if (playlist is YouTubePlaylist) {
      return playlist;
    }

    return YouTubePlaylist(
      id: playlist.id,
      name: playlist.name,
      description: playlist.description,
      ownerId: playlist.ownerId,
      ownerName: playlist.ownerName,
      isPublic: playlist.isPublic,
      isCollaborative: playlist.isCollaborative,
      totalTracks: playlist.totalTracks,
      imageUrl: playlist.imageUrl,
      platformMetadata: playlist.platformMetadata,
    );
  }
}
