import 'package:flutter/material.dart';
import 'package:pyro_music/features/artist/presentation/widgets/artist_header.dart';
import 'package:pyro_music/features/artist/presentation/widgets/artist_top_tracks.dart';
import 'package:pyro_music/features/artist/presentation/widgets/artist_albums.dart';
import 'package:pyro_music/features/artist/presentation/widgets/artist_related.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// 歌手详情页面
class ArtistPage extends StatelessWidget {
  /// 歌手ID
  final String artistId;

  const ArtistPage({
    super.key,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // 这里未来从 Provider 或 Service 获取真实的歌手信息
    const artistName = 'Artist Name';
    const String? imageUrl = null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 头部 App Bar
          const ArtistHeader(
            artistId: 'artistId',
            artistName: artistName,
            imageUrl: imageUrl,
          ),

          // 热门歌曲部分
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.popular_tracks,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const ArtistTopTracks(artistId: 'artistId'),

          // 专辑部分
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.albums,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const ArtistAlbums(artistId: 'artistId'),

          // 相似歌手/推荐部分
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.similar_artists,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const ArtistRelated(artistId: 'artistId'),
        ],
      ),
    );
  }
}
