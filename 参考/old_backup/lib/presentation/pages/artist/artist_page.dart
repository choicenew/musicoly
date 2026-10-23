import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/presentation/pages/artist/widgets/artist_header.dart';
import 'package:pyro_music/presentation/pages/artist/widgets/artist_top_tracks.dart';
import 'package:pyro_music/presentation/pages/artist/widgets/artist_albums.dart';
import 'package:pyro_music/presentation/pages/artist/widgets/artist_related.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// The artist details page
class ArtistPage extends StatelessWidget {
  /// The ID of the artist to display
  final String artistId;

  const ArtistPage({
    super.key,
    required this.artistId,
  });

  Future<ArtistModel?> _fetchArtist() async {
    // 模拟加载延迟和获取艺术家数据
    await Future.delayed(const Duration(seconds: 2));
    // 返回null模拟「未找到」，或返回ArtistModel实例表示成功
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ArtistModel?>(
        future: _fetchArtist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator(text: 'Loading artist...');
          }
          final artist = snapshot.data;
          if (artist == null) {
            return _buildErrorState(context);
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ArtistHeader(artist: artist),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArtistTopTracks(artist: artist),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArtistAlbums(artist: artist),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArtistRelated(artist: artist),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Artist not found',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'The artist you are looking for could not be found',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
