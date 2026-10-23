import 'package:flutter/foundation.dart';
import 'media_model.dart';

/// Comprehensive Model for Albums, Podcast Shows, and Audiobook Series
@immutable
class AlbumModel extends MediaModel {
  final List<String> artistIds;
  final List<String> artistNames;
  final DateTime? releaseDate;
  final int totalTracks;
  final String? albumType;
  final String? publisher;
  final String? feedUrl;
  final List<String>? genres;
  final int? popularity;
  final Map<String, dynamic> platformMetadata;

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
}
