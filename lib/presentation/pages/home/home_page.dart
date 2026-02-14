import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => context.go('/search'),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.go('/settings'),
                ),
              ],
            ),

            // Home content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome header
                    const HomeHeader(),
                    const SizedBox(height: 24),

                    // Quick actions
                    Row(
                      children: [
                        _QuickActionCard(
                          icon: Icons.folder,
                          label: l10n.local_music,
                          onTap: () => context.go('/local-music'),
                        ),
                        const SizedBox(width: 16),
                        _QuickActionCard(
                          icon: Icons.favorite,
                          label: l10n.favorites,
                          onTap: () => context.go('/favorites'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Recently played tracks
                    const RecentTracks(),
                    const SizedBox(height: 32),

                    // Featured playlists
                    const FeaturedPlaylists(),
                    const SizedBox(height: 32),

                    // Recommended artists
                    const RecommendedArtists(),
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

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
