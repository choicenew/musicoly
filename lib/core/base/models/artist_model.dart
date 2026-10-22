import 'package:flutter/foundation.dart';
import '../interfaces/media/artist_interface.dart';
import '../interfaces/media/media_interface.dart';
import 'media_model.dart';

/// Model class for artists, podcast hosts, creators
///
/// Implements ArtistInterface and extends MediaModel
@immutable
class ArtistModel extends MediaModel implements ArtistInterface {
  @override
  final List<String>? genres;

  @override
  final int? popularity;

  @override
  final int? followersCount;

  @override
  final Map<String, dynamic> platformMetadata;

  /// Create a new artist model
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ArtistModel &&
          runtimeType == other.runtimeType &&
          listEquals(genres, other.genres) &&
          popularity == other.popularity &&
          followersCount == other.followersCount;

  @override
  int get hashCode =>
      super.hashCode ^
      genres.hashCode ^
      popularity.hashCode ^
      followersCount.hashCode;
}
