import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/ad_media_model.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/presentation/widgets/common/album_card.dart';
import 'package:pyro_music/presentation/widgets/common/artist_card.dart';
import 'package:pyro_music/presentation/widgets/common/playlist_card.dart';

/// Data-driven horizontal media carousel section
class MediaCarouselSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<MediaModel> items;

  const MediaCarouselSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 150,
                  child: _buildItemCard(context, item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(BuildContext context, MediaModel item) {
    if (item is AdMediaModel) {
      return _buildAdCard(context, item);
    } else if (item is AlbumModel) {
      return AlbumCard(album: item, onTap: () {});
    } else if (item is ArtistModel) {
      return ArtistCard(artist: item, onTap: () {});
    } else if (item is PlaylistModel) {
      return PlaylistCard(playlist: item, onTap: () {});
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(item.name, textAlign: TextAlign.center),
    );
  }

  Widget _buildAdCard(BuildContext context, AdMediaModel ad) {
    final theme = Theme.of(context);

    if (ad.cardShape == AdCardShape.circle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipOval(
                  child: Container(
                    color: theme.colorScheme.tertiaryContainer,
                    alignment: Alignment.center,
                    child: Icon(Icons.campaign, size: 40, color: theme.colorScheme.tertiary),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ad.sponsorTag,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onTertiary,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(ad.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleSmall),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.tertiary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ad.sponsorTag,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onTertiary,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.stars, size: 36, color: theme.colorScheme.tertiary),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            ad.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
