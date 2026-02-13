import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/artist_interface.dart';

/// Spotify艺术家模型 - 实现ArtistInterface接口
@immutable
class SpotifyArtist implements ArtistInterface {
  /// 构造函数
  const SpotifyArtist({
    required this.id,
    required this.name,
    this.genres,
    this.popularity,
    this.followersCount,
    this.description,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建SpotifyArtist实例
  factory SpotifyArtist.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    final followers = json['followers'] as Map<String, dynamic>?;
    final followersCount = followers?['total'] as int?;

    return SpotifyArtist(
      id: json['id'] as String,
      name: json['name'] as String,
      genres: (json['genres'] as List?)?.cast<String>(),
      popularity: json['popularity'] as int?,
      followersCount: followersCount,
      imageUrl: imageUrl,
      platformMetadata: json,
    );
  }

  @override
  final String id;

  @override
  final String name;

  @override
  final List<String>? genres;

  @override
  final int? popularity;

  @override
  final int? followersCount;

  @override
  final String? description;

  @override
  final String? imageUrl;

  @override
  final Map<String, dynamic> platformMetadata;

  @override
  String get platform => 'spotify';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genres': genres,
      'popularity': popularity,
      'followers_count': followersCount,
      'description': description,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建SpotifyArtist的副本
  SpotifyArtist copyWith({
    String? id,
    String? name,
    List<String>? genres,
    int? popularity,
    int? followersCount,
    String? description,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return SpotifyArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      followersCount: followersCount ?? this.followersCount,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
