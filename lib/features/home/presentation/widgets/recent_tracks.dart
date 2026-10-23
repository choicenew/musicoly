import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/features/statistics/providers/play_stats_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// A widget that displays recently played tracks on the home page
class RecentTracks extends ConsumerWidget {
  const RecentTracks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final statsState = ref.watch(playStatsProvider);
    
    final tracks = statsState.recentPlays
        .map((stats) => stats.track)
        .whereType<TrackModel>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recent_tracks,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (tracks.isNotEmpty)
              TextButton(
                onPressed: () {
                  // Navigate to see all recent tracks
                },
                child: Text(l10n.see_all),
              ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (tracks.isEmpty)
          _buildEmptyState(theme, l10n)
        else
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tracks.length > 5 ? 5 : tracks.length, // Show max 5 tracks
            itemBuilder: (context, index) {
              final track = tracks[index];

              return TrackTile(
                track: track,
                onTap: () {
                  ref.read(playbackStateProvider.notifier).playTracks(
                    tracks.map((t) => t.id).toList(),
                    initialIndex: index,
                  );
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.no_recent_tracks,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.start_listening_hint,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
