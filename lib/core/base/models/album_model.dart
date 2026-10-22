import 'package:flutter/foundation.dart';
import '../interfaces/media/album_interface.dart';
import '../interfaces/media/media_interface.dart';
import 'media_model.dart';

/// Model class for albums, podcast shows, or audiobooks
///
/// Implements AlbumInterface and extends MediaModel
@immutable
class AlbumModel extends MediaModel implements AlbumInterface {
  @override
  final List<String> artistIds;

  @override
  final List<String> artistNames;

  @override
  final DateTime? releaseDate;

  @override
  final int totalTracks;

  @override
  final String? albumType;

  @override
  final String? publisher;

  @override
  final String? feedUrl;

  @override
  final List<String>? genres;

  @override
  final int? popularity;

  @override
  final Map<String, dynamic> platformMetadata;

  /// Create a new album model
  const AlbumModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.album,
    super.description,
    super.tags,
    required this.artistIds,
    required this.artistNames,
    this.releaseDate,
    required this.totalTracks,
    this.albumType,
    this.publisher,
    this.feedUrl,
    this.genres,
    this.popularity,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'artistIds': artistIds,
        'artistNames': artistNames,
        'releaseDate': releaseDate?.toIso8601String(),
        'totalTracks': totalTracks,
        'albumType': albumType,
        'publisher': publisher,
        'feedUrl': feedUrl,
        'genres': genres,
        'popularity': popularity,
        'platformMetadata': platformMetadata,
      };

  @override
  AlbumModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    List<String>? artistIds,
    List<String>? artistNames,
    DateTime? releaseDate,
    int? totalTracks,
    String? albumType,
    String? publisher,
    String? feedUrl,
    List<String>? genres,
    int? popularity,
    Map<String, dynamic>? platformMetadata,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      artistIds: artistIds ?? this.artistIds,
      artistNames: artistNames ?? this.artistNames,
      releaseDate: releaseDate ?? this.releaseDate,
      totalTracks: totalTracks ?? this.totalTracks,
      albumType: albumType ?? this.albumType,
      publisher: publisher ?? this.publisher,
      feedUrl: feedUrl ?? this.feedUrl,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is AlbumModel &&
          runtimeType == other.runtimeType &&
          artistIds == other.artistIds &&
          artistNames == other.artistNames &&
          releaseDate == other.releaseDate &&
          totalTracks == other.totalTracks &&
          albumType == other.albumType &&
          publisher == other.publisher &&
          feedUrl == other.feedUrl &&
          listEquals(genres, other.genres) &&
          popularity == other.popularity;

  @override
  int get hashCode =>
      super.hashCode ^
      artistIds.hashCode ^
      artistNames.hashCode ^
      releaseDate.hashCode ^
      totalTracks.hashCode ^
      albumType.hashCode ^
      publisher.hashCode ^
      feedUrl.hashCode ^
      genres.hashCode ^
      popularity.hashCode;
}
