import 'package:flutter/material.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// A widget that displays a welcome header on the home page
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final greeting = _getGreeting(l10n);
    const username = 'User'; // This would come from auth provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.welcome_back(username),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  /// Returns a greeting based on the current time of day
  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return l10n.good_morning;
    } else if (hour < 17) {
      return l10n.good_afternoon;
    } else {
      return l10n.good_evening;
    }
  }
}
