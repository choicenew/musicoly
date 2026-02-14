import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/home/widgets/home_header.dart';
import 'package:pyro_music/presentation/pages/home/widgets/featured_playlists.dart';
import 'package:pyro_music/presentation/pages/home/widgets/recent_tracks.dart';
import 'package:pyro_music/presentation/pages/home/widgets/recommended_artists.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// The home page of the application
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              title: Text(l10n.home),
              floating: true,
              snap: true,
            ),

            // Home content
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome header
                    HomeHeader(),
                    SizedBox(height: 32),

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
