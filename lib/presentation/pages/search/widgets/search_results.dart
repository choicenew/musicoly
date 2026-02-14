import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// A widget that displays search results
class SearchResults extends ConsumerWidget {
  /// The search query
  final String query;

  /// The selected filter (All, Tracks, Artists, Albums, Playlists)
  final String filter;

  const SearchResults({
    super.key,
    required this.query,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    
    // TODO: Integrate with search provider
    return _buildEmptyState(theme, l10n);
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.secondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.no_results_found(query),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
