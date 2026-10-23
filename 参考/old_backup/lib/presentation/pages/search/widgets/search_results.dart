import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
import 'package:pyro_music/core/base/models/playlist_model.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/presentation/widgets/common/artist_card.dart';
import 'package:pyro_music/presentation/widgets/common/album_card.dart';
import 'package:pyro_music/presentation/widgets/common/playlist_card.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// A widget that displays search results
class SearchResults extends StatelessWidget {
  /// The search query
  final String query;

  /// The selected filter (All, Tracks, Artists, Albums, Playlists)
  final String filter;

  const SearchResults({
    Key? key,
    required this.query,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This would normally come from a provider
    final bool isLoading = false;
    final bool hasError = false;
    final String errorMessage = '';

    // These would come from search provider
    final List<TrackModel> tracks = [];
    final List<ArtistModel> artists = [];
    final List<AlbumModel> albums = [];
    final List<PlaylistModel> playlists = [];

    if (isLoading) {
      return const LoadingIndicator(text: 'Searching...');
    }

    if (hasError) {
      return _buildErrorState(theme, errorMessage);
    }

    // Check if there are no results
    final bool noResults = tracks.isEmpty &&
        artists.isEmpty &&
        albums.isEmpty &&
        playlists.isEmpty;

    if (noResults) {
      return _buildEmptyState(theme);
    }

    // Show results based on selected filter
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show tracks if filter is 'All' or 'Tracks'
          if (filter == 'All' || filter == 'Tracks') ...[
            _buildSectionHeader(theme, 'Tracks'),
            const SizedBox(height: 16),
            _buildTracksList(tracks),
            const SizedBox(height: 32),
          ],

          // Show artists if filter is 'All' or 'Artists'
          if (filter == 'All' || filter == 'Artists') ...[
            _buildSectionHeader(theme, 'Artists'),
            const SizedBox(height: 16),
            _buildArtistsList(artists),
            const SizedBox(height: 32),
          ],

          // Show albums if filter is 'All' or 'Albums'
          if (filter == 'All' || filter == 'Albums') ...[
            _buildSectionHeader(theme, 'Albums'),
            const SizedBox(height: 16),
            _buildAlbumsList(albums),
            const SizedBox(height: 32),
          ],

          // Show playlists if filter is 'All' or 'Playlists'
          if (filter == 'All' || filter == 'Playlists') ...[
            _buildSectionHeader(theme, 'Playlists'),
            const SizedBox(height: 16),
            _buildPlaylistsList(playlists),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTracksList(List<TrackModel> tracks) {
    if (tracks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text('No tracks found'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];

        return TrackTile(
          track: track,
          onTap: () {
            // Play this track
          },
        );
      },
    );
  }

  Widget _buildArtistsList(List<ArtistModel> artists) {
    if (artists.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text('No artists found'),
      );
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 120,
              child: ArtistCard(
                artist: artist,
                onTap: () {
                  // Navigate to artist details
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAlbumsList(List<AlbumModel> albums) {
    if (albums.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text('No albums found'),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 160,
              child: AlbumCard(
                album: album,
                onTap: () {
                  // Navigate to album details
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaylistsList(List<PlaylistModel> playlists) {
    if (playlists.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text('No playlists found'),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 160,
              child: PlaylistCard(
                playlist: playlist,
                onTap: () {
                  // Navigate to playlist details
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term or filter',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error occurred',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage.isNotEmpty
                ? errorMessage
                : 'Something went wrong. Please try again.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
