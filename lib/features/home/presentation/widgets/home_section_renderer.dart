import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'ad_banner_section.dart';
import 'media_carousel_section.dart';
import 'media_grid_section.dart';
import 'track_list_section.dart';

/// 100% Pure Data-Driven Universal Home Section Renderer
class HomeSectionRenderer extends StatelessWidget {
  final HomeSectionModel section;

  const HomeSectionRenderer({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    switch (section.type) {
      case HomeSectionType.quickActions:
        return _buildQuickActions(context);
      case HomeSectionType.trackList:
        return TrackListSection(
          title: section.title,
          subtitle: section.subtitle,
          items: section.items,
        );
      case HomeSectionType.carousel:
        return MediaCarouselSection(
          title: section.title,
          subtitle: section.subtitle,
          items: section.items,
        );
      case HomeSectionType.grid:
        return MediaGridSection(
          title: section.title,
          subtitle: section.subtitle,
          items: section.items,
        );
      case HomeSectionType.banner:
        return _buildBanner(context);
      case HomeSectionType.adBanner:
      case HomeSectionType.adCard:
        return AdBannerSection(section: section);
    }
  }

  Widget _buildQuickActions(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
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
    );
  }

  Widget _buildBanner(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (section.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              section.subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
              ),
            ),
          ],
        ],
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
