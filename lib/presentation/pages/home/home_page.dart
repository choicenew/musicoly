import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/home/widgets/home_header.dart';
import 'package:pyro_music/presentation/pages/home/widgets/featured_playlists.dart';
import 'package:pyro_music/presentation/pages/home/widgets/recent_tracks.dart';
import 'package:pyro_music/presentation/pages/home/widgets/recommended_artists.dart';

/// The home page of the application
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            const SliverAppBar(
              title: Text('Home'),
              floating: true,
              snap: true,
            ),

            // Home content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Welcome header
                    HomeHeader(),
                    SizedBox(height: 24),

                    // Recently played tracks
                    RecentTracks(),
                    SizedBox(height: 32),

                    // Featured playlists
                    FeaturedPlaylists(),
                    SizedBox(height: 32),

                    // Recommended artists
                    RecommendedArtists(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
