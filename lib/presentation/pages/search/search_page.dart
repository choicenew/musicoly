import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_bar.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_results.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_filters.dart';
import 'package:pyro_music/features/search/providers/search_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

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
      ref.read(searchProvider.notifier).clearResults();
      return;
    }
    ref.read(searchProvider.notifier).updateQuery(query);
    ref.read(searchProvider.notifier).search();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    // Apply the filter to search results
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final searchState = ref.watch(searchProvider);
    final isSearching = searchState.query.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                onSearch: _onSearch,
                initialQuery: searchState.query,
              ),
            ),

            // Search filters
            if (isSearching)
              SearchFilters(
                selectedFilter: _selectedFilter,
                onFilterChanged: _onFilterChanged,
              ),

            // Search results or suggestions
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.search_for_music,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.search_hint,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
