import 'package:flutter/foundation.dart';
import 'media_model.dart';

/// Comprehensive Model for Artists, Podcast Hosts, and Creators
@immutable
class ArtistModel extends MediaModel {
  final List<String>? genres;
  final int? popularity;
  final int? followersCount;
  final Map<String, dynamic> platformMetadata;

  const ArtistModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.artist,
    super.description,
    super.tags,
    this.genres,
    this.popularity,
    this.followersCount,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'genres': genres,
        'popularity': popularity,
        'followersCount': followersCount,
        'platformMetadata': platformMetadata,
      };

  @override
  ArtistModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    List<String>? genres,
    int? popularity,
    int? followersCount,
    Map<String, dynamic>? platformMetadata,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      followersCount: followersCount ?? this.followersCount,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
