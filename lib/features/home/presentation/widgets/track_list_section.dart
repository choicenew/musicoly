import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/ad_media_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';

/// Data-driven track list section with native ad tile infiltration
class TrackListSection extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final List<MediaModel> items;

  const TrackListSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final tracks = items.whereType<TrackModel>().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
            ),
          ),
        ],
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length > 6 ? 6 : items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            if (item is AdMediaModel) {
              return _buildAdTile(context, item);
            } else if (item is TrackModel) {
              return TrackTile(
                track: item,
                onTap: () {
                  ref.read(playbackStateProvider.notifier).playTracks(
                        tracks.map((t) => t.id).toList(),
                        initialIndex: tracks.indexOf(item),
                      );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildAdTile(BuildContext context, AdMediaModel ad) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.tertiary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.stars, color: theme.colorScheme.onTertiary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        ad.sponsorTag,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onTertiary,
                          fontSize: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ad.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                if (ad.description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    ad.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
