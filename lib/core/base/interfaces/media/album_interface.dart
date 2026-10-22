import 'package:flutter/foundation.dart';
import 'media_interface.dart';

/// Interface for album / podcast show / audiobook collection media type
@immutable
abstract class AlbumInterface extends MediaInterface {
  /// List of artist or creator IDs associated with this album/show
  List<String> get artistIds;

  /// List of artist or creator names associated with this album/show
  List<String> get artistNames;

  /// Release date of the album or show start date
  DateTime? get releaseDate;

  /// Total number of tracks or episodes
  int get totalTracks;

  /// Collection type (album, single, compilation, podcastShow, audiobook)
  String? get albumType;

  /// Publisher, label, or network
  String? get publisher;

  /// RSS feed URL (for podcast shows)
  String? get feedUrl;

  /// Genres associated with this album/show
  List<String>? get genres;

  /// Popularity score (0-100)
  int? get popularity;

  /// Platform-specific metadata
  Map<String, dynamic> get platformMetadata;
}
