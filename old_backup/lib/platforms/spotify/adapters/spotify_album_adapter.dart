import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/album_interface.dart';
import '../models/spotify_album.dart';

/// Spotify专辑适配器
///
/// 负责将Spotify特定的专辑模型转换为应用程序通用的接口模型
@immutable
class SpotifyAlbumAdapter {
  /// 将SpotifyAlbum转换为AlbumInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为SpotifyAlbum已经实现了AlbumInterface接口
  static AlbumInterface toInterface(SpotifyAlbum album) {
    return album;
  }

  /// 将AlbumInterface转换为SpotifyAlbum
  ///
  /// 如果传入的album已经是SpotifyAlbum类型，则直接返回
  /// 否则，创建一个新的SpotifyAlbum实例
  static SpotifyAlbum fromInterface(AlbumInterface album) {
    if (album is SpotifyAlbum) {
      return album;
    }

    return SpotifyAlbum(
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
