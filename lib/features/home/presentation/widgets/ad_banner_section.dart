import 'package:flutter/material.dart';
import 'package:pyro_music/core/models/home_section_model.dart';

/// Clean Sponsor Ad Section Widget without intrusive text box overlays
class AdBannerSection extends StatelessWidget {
  final HomeSectionModel section;

  const AdBannerSection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionLabel = section.extra['actionLabel'] as String? ?? 'Learn More';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.tertiary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          if (section.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              section.subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onTertiaryContainer.withValues(alpha: 0.8),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(actionLabel),
            ),
          ),
        ],
      ),
    );
  }
}
