import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/album_interface.dart';
import '../models/youtube_album.dart';

/// YouTube Music专辑适配器
///
/// 负责将YouTube Music特定的专辑模型转换为应用程序通用的接口模型
@immutable
class YouTubeAlbumAdapter {
  /// 将YouTubeAlbum转换为AlbumInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为YouTubeAlbum已经实现了AlbumInterface接口
  static AlbumInterface toInterface(YouTubeAlbum album) {
    return album;
  }

  /// 将AlbumInterface转换为YouTubeAlbum
  ///
  /// 如果传入的album已经是YouTubeAlbum类型，则直接返回
  /// 否则，创建一个新的YouTubeAlbum实例
  static YouTubeAlbum fromInterface(AlbumInterface album) {
    if (album is YouTubeAlbum) {
      return album;
    }

    return YouTubeAlbum(
      id: album.id,
      name: album.name,
      artistIds: album.artistIds,
      artistNames: album.artistNames,
      releaseDate: album.releaseDate,
      totalTracks: album.totalTracks,
      albumType: album.albumType,
      genres: album.genres,
      popularity: album.popularity,
      imageUrl: album.imageUrl,
      platformMetadata: album.platformMetadata,
    );
  }
}
