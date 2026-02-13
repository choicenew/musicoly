import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/artist_interface.dart';
import '../models/youtube_artist.dart';

/// YouTube Music艺术家适配器
///
/// 负责将YouTube Music特定的艺术家模型转换为应用程序通用的接口模型
@immutable
class YouTubeArtistAdapter {
  /// 将YouTubeArtist转换为ArtistInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为YouTubeArtist已经实现了ArtistInterface接口
  static ArtistInterface toInterface(YouTubeArtist artist) {
    return artist;
  }

  /// 将ArtistInterface转换为YouTubeArtist
  ///
  /// 如果传入的artist已经是YouTubeArtist类型，则直接返回
  /// 否则，创建一个新的YouTubeArtist实例
  static YouTubeArtist fromInterface(ArtistInterface artist) {
    if (artist is YouTubeArtist) {
      return artist;
    }

    return YouTubeArtist(
      id: artist.id,
      name: artist.name,
      genres: artist.genres,
      popularity: artist.popularity,
      followers: artist.followersCount,
      description: artist.description,
      imageUrl: artist.imageUrl,
      platformMetadata: artist.platformMetadata,
    );
  }
}
