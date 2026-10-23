import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/artist_interface.dart';

/// YouTube Music艺术家模型 - 实现ArtistInterface接口
@immutable
class YouTubeArtist implements ArtistInterface {
  /// 构造函数
  const YouTubeArtist({
    required this.id,
    required this.name,
    this.description,
    this.followers,
    this.popularity,
    this.genres,
    this.imageUrl,
    this.isVerified = false,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubeArtist实例
  factory YouTubeArtist.fromJson(Map<String, dynamic> json) {
    return YouTubeArtist(
      id: json['id'] as String? ?? json['channelId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      followers: json['subscriberCount'] as int?,
      popularity: json['popularity'] as int?,
      genres: (json['genres'] as List?)?.cast<String>(),
      imageUrl: json['thumbnailUrl'] as String? ?? json['thumbnail'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      platformMetadata: json,
    );
  }

  @override
  final String id;

  @override
  final String name;

  @override
  final String? description;

  @override
  final int? followers;

  @override
  final int? popularity;

  @override
  final List<String>? genres;

  @override
  final String? imageUrl;

  /// 是否已验证艺术家
  final bool isVerified;

  @override
  int? get followersCount => followers;

  @override
  final Map<String, dynamic> platformMetadata;

  @override
  String get platform => 'youtube_music';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'followers': followers,
      'popularity': popularity,
      'genres': genres,
      'image_url': imageUrl,
      'is_verified': isVerified,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubeArtist的副本
  YouTubeArtist copyWith({
    String? id,
    String? name,
    String? description,
    int? followers,
    int? popularity,
    List<String>? genres,
    String? imageUrl,
    bool? isVerified,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubeArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      followers: followers ?? this.followers,
      popularity: popularity ?? this.popularity,
      genres: genres ?? this.genres,
      imageUrl: imageUrl ?? this.imageUrl,
      isVerified: isVerified ?? this.isVerified,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
