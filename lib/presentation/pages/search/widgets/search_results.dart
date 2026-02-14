import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    
    // TODO: Integrate with search provider
    return _buildEmptyState(theme);
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.secondary.withAlpha(128),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found for "$query"',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.titleMedium?.color?.withAlpha(179),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Search failed: $error',
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
