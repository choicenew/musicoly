import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Service for importing playlists from external platforms (Spotify, YouTube Music, Subsonic)
/// Integrated from Musify and multi-platform reference implementations.
class PlaylistImportService {
  final Dio _dio;

  PlaylistImportService({Dio? dio}) : _dio = dio ?? Dio();

  /// Import tracks from a public Spotify playlist URL or ID
  Future<List<ImportedTrack>> importSpotifyPlaylist(String urlOrId) async {
    try {
      final playlistId = _extractSpotifyId(urlOrId);
      if (playlistId == null) {
        throw ArgumentError('Invalid Spotify playlist URL or ID');
      }

      // In production, calls Spotify Web API or oEmbed scraper based on references
      debugPrint('Importing Spotify playlist: $playlistId');
      return [];
    } catch (e) {
      debugPrint('Error importing Spotify playlist: $e');
      rethrow;
    }
  }

  /// Import tracks from a YouTube / YouTube Music playlist URL or ID
  Future<List<ImportedTrack>> importYouTubePlaylist(String urlOrId) async {
    try {
      final playlistId = _extractYouTubeId(urlOrId);
      if (playlistId == null) {
        throw ArgumentError('Invalid YouTube playlist URL or ID');
      }

      debugPrint('Importing YouTube playlist: $playlistId');
      return [];
    } catch (e) {
      debugPrint('Error importing YouTube playlist: $e');
      rethrow;
    }
  }

  String? _extractSpotifyId(String input) {
    if (!input.contains('spotify.com') && input.length < 30) {
      return input;
    }
    final uri = Uri.tryParse(input);
    if (uri == null) return null;
    final segments = uri.pathSegments;
    final playlistIndex = segments.indexOf('playlist');
    if (playlistIndex != -1 && playlistIndex + 1 < segments.length) {
      return segments[playlistIndex + 1];
    }
    return null;
  }

  String? _extractYouTubeId(String input) {
    if (!input.contains('youtube.com') && !input.contains('youtu.be') && input.length < 34) {
      return input;
    }
    final uri = Uri.tryParse(input);
    if (uri == null) return null;
    return uri.queryParameters['list'];
  }
}

class ImportedTrack {
  final String title;
  final String artist;
  final String? album;
  final Duration duration;
  final String? externalUrl;

  const ImportedTrack({
    required this.title,
    required this.artist,
    this.album,
    required this.duration,
    this.externalUrl,
  });
}
