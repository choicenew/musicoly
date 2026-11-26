import 'package:flutter/foundation.dart';

/// Service for managing playlist folders and nested categorization.
/// Integrated from Musify playlist folder reference implementation.
class PlaylistFolderService {
  final Map<String, PlaylistFolder> _folders = {};

  /// Create a new playlist folder
  Future<PlaylistFolder> createFolder(String name, {List<String> playlistIds = const []}) async {
    final folderId = DateTime.now().millisecondsSinceEpoch.toString();
    final folder = PlaylistFolder(
      id: folderId,
      name: name,
      playlistIds: playlistIds,
    );
    _folders[folderId] = folder;
    debugPrint('Created playlist folder: $name (ID: $folderId)');
    return folder;
  }

  /// Add playlist to folder
  Future<void> addPlaylistToFolder(String folderId, String playlistId) async {
    final folder = _folders[folderId];
    if (folder != null) {
      if (!folder.playlistIds.contains(playlistId)) {
        folder.playlistIds.add(playlistId);
        debugPrint('Added playlist $playlistId to folder $folderId');
      }
    }
  }

  /// Remove playlist from folder
  Future<void> removePlaylistFromFolder(String folderId, String playlistId) async {
    final folder = _folders[folderId];
    if (folder != null) {
      folder.playlistIds.remove(playlistId);
      debugPrint('Removed playlist $playlistId from folder $folderId');
    }
  }

  /// Get all folders
  List<PlaylistFolder> getAllFolders() {
    return _folders.values.toList();
  }

  /// Delete folder
  Future<void> deleteFolder(String folderId) async {
    _folders.remove(folderId);
    debugPrint('Deleted playlist folder: $folderId');
  }
}

class PlaylistFolder {
  final String id;
  final String name;
  final List<String> playlistIds;

  PlaylistFolder({
    required this.id,
    required this.name,
    required this.playlistIds,
  });
}
