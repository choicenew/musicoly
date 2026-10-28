import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/artist_model.dart';
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
    final artist = ArtistModel(
      id: artistId,
      name: 'Artist',
      platform: 'local',
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 头部 App Bar
          SliverToBoxAdapter(
            child: ArtistHeader(artist: artist),
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
          SliverToBoxAdapter(
            child: ArtistTopTracks(artist: artist),
          ),

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
          SliverToBoxAdapter(
            child: ArtistAlbums(artist: artist),
          ),

          // 相似歌手/推荐部分
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.fans_also_like,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ArtistRelated(artist: artist),
          ),
        ],
      ),
    );
  }
}
