import 'package:flutter/material.dart';

/// A widget that displays filter options for search results
class SearchFilters extends StatelessWidget {
  /// The currently selected filter
  final String selectedFilter;

  /// Callback when a filter is selected
  final Function(String) onFilterChanged;

  const SearchFilters({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filters = ['All', 'Tracks', 'Artists', 'Albums', 'Playlists'];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (_) => onFilterChanged(filter),
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
