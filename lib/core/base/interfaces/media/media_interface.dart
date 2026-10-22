import 'package:flutter/foundation.dart';

/// Enumeration representing the domain media category (Music, Podcast, Audiobook, etc.)
enum MediaType {
  musicTrack,
  podcastEpisode,
  audiobookChapter,
  album,
  podcastShow,
  audiobook,
  artist,
  podcastHost,
  playlist,
  collection,
  custom;

  String get value => name;

  static MediaType fromString(String? type) {
    if (type == null) return MediaType.musicTrack;
    return MediaType.values.firstWhere(
      (e) => e.name == type || e.name.toLowerCase() == type.toLowerCase(),
      orElse: () => MediaType.musicTrack,
    );
  }
}

/// Base interface for all media types in the application
///
/// Defines common properties for all media types (tracks, episodes, albums, shows, artists, playlists).
@immutable
abstract class MediaInterface {
  /// Unique identifier for the media
  String get id;

  /// Name or title of the media
  String get name;

  /// URL to the media's image/thumbnail
  String? get imageUrl;

  /// Platform source of this media (e.g., "local", "rss", "youtube_music", "custom")
  String get platform;

  /// Domain category of the media (musicTrack, podcastEpisode, etc.)
  MediaType get mediaType;

  /// Optional description or summary
  String? get description;

  /// Optional tags or genres
  List<String>? get tags;

  /// Convert the media to a JSON representation
  Map<String, dynamic> toJson();
}
