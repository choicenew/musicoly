import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/playlist_interface.dart';
import '../models/spotify_playlist.dart';

/// Spotify播放列表适配器
///
/// 负责将Spotify特定的播放列表模型转换为应用程序通用的接口模型
@immutable
class SpotifyPlaylistAdapter {
  /// 将SpotifyPlaylist转换为PlaylistInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为SpotifyPlaylist已经实现了PlaylistInterface接口
  static PlaylistInterface toInterface(SpotifyPlaylist playlist) {
    return playlist;
  }

  /// 将PlaylistInterface转换为SpotifyPlaylist
  ///
  /// 如果传入的playlist已经是SpotifyPlaylist类型，则直接返回
  /// 否则，创建一个新的SpotifyPlaylist实例
  static SpotifyPlaylist fromInterface(PlaylistInterface playlist) {
    if (playlist is SpotifyPlaylist) {
      return playlist;
    }

    return SpotifyPlaylist(
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
