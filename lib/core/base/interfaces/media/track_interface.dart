import 'package:flutter/foundation.dart';
import 'media_interface.dart';

/// Interface for audio track / podcast episode / media item
///
/// Defines properties for music tracks, podcast episodes, audiobook chapters, etc.
@immutable
abstract class TrackInterface extends MediaInterface {
  /// List of artist / creator / host IDs associated with this track/episode
  List<String> get artistIds;

  /// List of artist / creator / host names associated with this track/episode
  List<String> get artistNames;

  /// Album or podcast show ID this track belongs to
  String? get albumId;

  /// Album or podcast show name this track belongs to
  String? get albumName;

  /// Duration of the track in milliseconds
  int get durationMs;

  /// Whether this track is playable
  bool get isPlayable;

  /// Track number in the album or episode number in a podcast
  int? get trackNumber;

  /// Disc number or season number
  int? get discNumber;

  /// Podcast episode number
  int? get episodeNumber;

  /// Podcast season number
  int? get seasonNumber;

  /// Release date or podcast publication date
  DateTime? get publishDate;

  /// Popularity score (0-100)
  int? get popularity;

  /// Whether this track is explicit
  bool get isExplicit;

  /// Preview URL for the track
  String? get previewUrl;

  /// Direct audio stream URL (for podcasts/remote audio)
  String? get audioStreamUrl;

  /// Audio MIME type (e.g. "audio/mpeg")
  String? get mimeType;

  /// Local file path (if downloaded/cached)
  String? get localPath;

  /// Whether this track is marked as favorite
  bool get isFavorite;

  /// Lyrics or episode transcript
  String? get lyrics;

  /// Platform-specific metadata
  Map<String, dynamic> get platformMetadata;
}
