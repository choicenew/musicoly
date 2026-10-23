import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/core/base/models/album_model.dart';
import 'package:pyro_music/presentation/widgets/common/album_card.dart';

/// Widget that displays the albums of an artist
class ArtistAlbums extends StatelessWidget {
  /// The artist whose albums to display
  final ArtistModel artist;

  /// Creates a new artist albums widget
  const ArtistAlbums({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // In a real implementation, these albums would come from a provider
    // This is just a placeholder for demonstration
    // Remove isLoading and its usage
    final List<AlbumModel> albums = [];
    // const bool isLoading = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          'Albums',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Albums grid
        // Remove the isLoading check and loading indicator
        if (albums.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.album_outlined,
                    size: 48,
                    color: Color.lerp(
                      theme.colorScheme.onSurface.withAlpha(0),
                      theme.colorScheme.onSurface,
                      0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No albums available',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
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
                        Navigator.pushNamed(
                          context, 
                          '/album/${album.id}',
                          arguments: album,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

        // Show all albums button (if there are more than can be displayed)
        if (albums.length > 5)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/artist/${artist.id}/albums',
                    arguments: artist,
                  );
                },
                child: const Text('See All Albums'),
              ),
            ),
          ),
      ],
    );
  }
}
