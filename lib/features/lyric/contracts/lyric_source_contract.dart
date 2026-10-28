import 'package:pyro_music/core/models/track_model.dart';

/// Universal Lyric Source Contract ABI
abstract class LyricSourceContract {
  String get pluginId;
  String get pluginName;

  /// Fetch or search lyrics for a track
  Future<String?> fetchLyrics(TrackModel track);

  /// Search lyrics by query string
  Future<List<String>> searchLyrics(String query);
}
