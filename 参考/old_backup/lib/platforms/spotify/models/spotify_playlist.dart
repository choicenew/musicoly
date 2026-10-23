import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/playlist_interface.dart';

/// Spotify播放列表模型 - 实现PlaylistInterface接口
@immutable
class SpotifyPlaylist implements PlaylistInterface {
  /// 构造函数
  const SpotifyPlaylist({
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

  /// 从JSON创建SpotifyPlaylist实例
  factory SpotifyPlaylist.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    final owner = json['owner'] as Map<String, dynamic>?;

    return SpotifyPlaylist(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ownerId: owner?['id'] as String?,
      ownerName: owner?['display_name'] as String?,
      isPublic: json['public'] as bool? ?? true,
      isCollaborative: json['collaborative'] as bool? ?? false,
      totalTracks:
          (json['tracks'] as Map<String, dynamic>?)!.containsKey('total')
              ? (json['tracks'] as Map<String, dynamic>)['total'] as int
              : 0,
      imageUrl: imageUrl,
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
  String get platform => 'spotify';

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

  /// 创建SpotifyPlaylist的副本
  SpotifyPlaylist copyWith({
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
    return SpotifyPlaylist(
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
