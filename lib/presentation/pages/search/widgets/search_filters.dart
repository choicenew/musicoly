import 'package:flutter/material.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// A widget that displays filter options for search results
class SearchFilters extends StatelessWidget {
  /// The currently selected filter
  final String selectedFilter;

  /// Callback when a filter is selected
  final Function(String) onFilterChanged;

  const SearchFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final filters = [
      {'label': l10n.all, 'value': 'All'},
      {'label': l10n.tracks, 'value': 'Tracks'},
      {'label': l10n.artists, 'value': 'Artists'},
      {'label': l10n.albums, 'value': 'Albums'},
      {'label': l10n.playlists, 'value': 'Playlists'},
    ];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter['value'] == selectedFilter;

          return FilterChip(
            label: Text(filter['label']!),
            selected: isSelected,
            onSelected: (_) => onFilterChanged(filter['value']!),
            backgroundColor: theme.colorScheme.surface,
            selectedColor: theme.colorScheme.primaryContainer,
            labelStyle: TextStyle(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          );
        },
      ),
    );
  }
}
