import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/search/providers/search_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'widgets/search_bar.dart';
import 'widgets/search_filters.dart';
import 'widgets/search_results.dart';

/// The search page of the application
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _selectedFilter = 'All';

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      ref.read(searchNotifierProvider.notifier).clearResults();
      return;
    }
    ref.read(searchNotifierProvider.notifier).updateQuery(query);
    ref.read(searchNotifierProvider.notifier).search();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final searchState = ref.watch(searchNotifierProvider);
    final isSearching = searchState.query.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                onSearch: _onSearch,
                initialQuery: searchState.query,
              ),
            ),
            if (isSearching)
              SearchFilters(
                selectedFilter: _selectedFilter,
                onFilterChanged: _onFilterChanged,
              ),
            Expanded(
              child: isSearching
                  ? SearchResults(
                      query: searchState.query,
                      filter: _selectedFilter,
                    )
                  : _buildSearchSuggestions(l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions(AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.search_for_music,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.search_hint,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars, size: 14, color: theme.colorScheme.tertiary),
                const SizedBox(width: 6),
                Text(
                  'Featured • Studio Quality Lossless DAC',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
