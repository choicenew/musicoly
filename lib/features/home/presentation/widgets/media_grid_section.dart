import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/ad_media_model.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/presentation/widgets/common/artist_card.dart';

/// Data-driven responsive media grid section
class MediaGridSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<MediaModel> items;

  const MediaGridSection({
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
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: items.length > 4 ? 4 : items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            if (item is AdMediaModel) {
              return _buildAdGridTile(context, item);
            } else if (item is ArtistModel) {
              return ArtistCard(artist: item, onTap: () {});
            }
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(item.name),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdGridTile(BuildContext context, AdMediaModel ad) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.tertiary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 9,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ad.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
    );
  }
}
