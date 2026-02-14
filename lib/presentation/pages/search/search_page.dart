import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_bar.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_results.dart';
import 'package:pyro_music/presentation/pages/search/widgets/search_filters.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// The search page of the application
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';
  String _selectedFilter = 'All';
  bool _isSearching = false;

  void _onSearch(String query) {
    setState(() {
      _query = query;
      _isSearching = query.isNotEmpty;
    });
    // Trigger search using the query
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                onSearch: _onSearch,
                initialQuery: _query,
              ),
            ),

            // Search filters
            if (_isSearching)
              SearchFilters(
                selectedFilter: _selectedFilter,
                onFilterChanged: _onFilterChanged,
              ),

            // Search results or suggestions
            Expanded(
              child: _isSearching
                  ? SearchResults(
                      query: _query,
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
