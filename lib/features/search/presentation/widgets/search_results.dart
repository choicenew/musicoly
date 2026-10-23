import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pyro_music/features/search/providers/search_provider.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';
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
    final searchState = ref.watch(searchProvider);

    if (searchState.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchState.error != null) {
      return _buildErrorState(context, ref, theme, l10n, searchState.error!);
    }

    if (searchState.results.isEmpty) {
      return _buildEmptyState(theme, l10n);
    }

    // Filter results if needed (currently TrackSourceManager might only return tracks)
    final filteredResults = searchState.results;

    return ListView.builder(
      itemCount: filteredResults.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final result = filteredResults[index];
        return _buildResultTile(context, ref, result);
      },
    );
  }

  Widget _buildResultTile(BuildContext context, WidgetRef ref, SourceInfo result) {
    final theme = Theme.of(context);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: result.thumbnailUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: theme.colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.music_note),
          ),
          errorWidget: (context, url, error) => Container(
            color: theme.colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.music_note),
          ),
        ),
      ),
      title: Text(
        result.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        result.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        _formatDuration(result.duration),
        style: theme.textTheme.bodySmall,
      ),
      onTap: () => ref.read(searchProvider.notifier).playResult(result),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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

  Widget _buildErrorState(BuildContext context, WidgetRef ref, ThemeData theme, AppLocalizations l10n, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(searchProvider.notifier).search(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
