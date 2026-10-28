import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';

/// Controller for search functionality
///
/// Handles user interactions related to searching
class SearchController {
  /// The ref to access providers
  final Ref _ref;

  /// Create a new search controller
  SearchController(this._ref);

  /// Get the current search state
  SearchStateData get state => _ref.read(searchProvider);

  /// Get the search state notifier
  SearchNotifier get _notifier => _ref.read(searchProvider.notifier);

  /// Update the search query without performing a search
  void updateQuery(String query) {
    _notifier.updateQuery(query);
  }

  /// Perform a search with the current query
  Future<void> search({int limit = 20, int offset = 0}) async {
    await _notifier.search(null, limit, offset);
  }

  /// Clear the current search results
  void clearResults() {
    _notifier.clearResults();
  }

  /// Provider for the search controller
  static final provider = Provider.autoDispose<SearchController>((ref) {
    return SearchController(ref);
  });
}
