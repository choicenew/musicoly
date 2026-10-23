import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/playlist_interface.dart';

/// YouTube Music播放列表模型 - 实现PlaylistInterface接口
@immutable
class YouTubePlaylist implements PlaylistInterface {
  /// 构造函数
  const YouTubePlaylist({
    required this.id,
    required this.name,
    this.description,
    this.ownerId,
    this.ownerName,
    this.isPublic = true,
    this.isCollaborative = false,
    required this.totalTracks,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubePlaylist实例
  factory YouTubePlaylist.fromJson(Map<String, dynamic> json) {
    return YouTubePlaylist(
      id: json['id'] as String,
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      description: json['description'] as String?,
      ownerId: json['authorId'] as String? ?? json['ownerId'] as String?,
      ownerName: json['authorName'] as String? ?? json['ownerName'] as String?,
      isPublic: json['isPublic'] as bool? ?? true,
      isCollaborative: json['isCollaborative'] as bool? ?? false,
      totalTracks:
          json['trackCount'] as int? ?? (json['tracks'] as List?)?.length ?? 0,
      imageUrl: json['thumbnailUrl'] as String? ?? json['thumbnail'] as String?,
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
  final String? ownerId;

  @override
  final String? ownerName;

  @override
  final bool isPublic;

  @override
  final bool isCollaborative;

  @override
  final int totalTracks;

  @override
  final String? imageUrl;

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
      'owner_id': ownerId,
      'owner_name': ownerName,
      'is_public': isPublic,
      'is_collaborative': isCollaborative,
      'total_tracks': totalTracks,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubePlaylist的副本
  YouTubePlaylist copyWith({
    String? id,
    String? name,
    String? description,
    String? ownerId,
    String? ownerName,
    bool? isPublic,
    bool? isCollaborative,
    int? totalTracks,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubePlaylist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      isPublic: isPublic ?? this.isPublic,
      isCollaborative: isCollaborative ?? this.isCollaborative,
      totalTracks: totalTracks ?? this.totalTracks,
      imageUrl: imageUrl ?? this.imageUrl,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
