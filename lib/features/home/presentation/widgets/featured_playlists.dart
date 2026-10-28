import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/presentation/widgets/common/playlist_card.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// A widget that displays featured playlists on the home page
class FeaturedPlaylists extends StatelessWidget {
  const FeaturedPlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    // This would normally come from a provider
    final List<PlaylistModel> playlists =
        []; // Would come from playlist provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.featured_playlists,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to see all featured playlists
              },
              child: Text(l10n.see_all),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (playlists.isEmpty)
          _buildEmptyState(theme, l10n)
        else
          SizedBox(
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
          ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.playlist_play,
            size: 48,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.no_featured_playlists,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
