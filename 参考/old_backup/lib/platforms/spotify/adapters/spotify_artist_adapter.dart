import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/artist_interface.dart';
import '../models/spotify_artist.dart';

/// Spotify艺术家适配器
///
/// 负责将Spotify特定的艺术家模型转换为应用程序通用的接口模型
@immutable
class SpotifyArtistAdapter {
  /// 将SpotifyArtist转换为ArtistInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为SpotifyArtist已经实现了ArtistInterface接口
  static ArtistInterface toInterface(SpotifyArtist artist) {
    return artist;
  }

  /// 将ArtistInterface转换为SpotifyArtist
  ///
  /// 如果传入的artist已经是SpotifyArtist类型，则直接返回
  /// 否则，创建一个新的SpotifyArtist实例
  static SpotifyArtist fromInterface(ArtistInterface artist) {
    if (artist is SpotifyArtist) {
      return artist;
    }

    return SpotifyArtist(
      id: artist.id,
      name: artist.name,
      genres: artist.genres,
      popularity: artist.popularity,
      followersCount: artist.followersCount,
      description: artist.description,
      imageUrl: artist.imageUrl,
      platformMetadata: artist.platformMetadata,
    );
  }
}
