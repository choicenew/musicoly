import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/collection_interface.dart';

/// Spotify集合模型 - 实现CollectionInterface接口
@immutable
class SpotifyCollection implements CollectionInterface {
  /// 构造函数
  const SpotifyCollection({
    required this.id,
    required this.name,
    this.description,
    required this.collectionType,
    required this.totalItems,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建SpotifyCollection实例
  factory SpotifyCollection.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    return SpotifyCollection(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      collectionType: json['type'] as String? ?? 'unknown',
      totalItems: json['total'] as int? ?? 0,
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
  final String collectionType;

  @override
  final int totalItems;

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
      'collection_type': collectionType,
      'total_items': totalItems,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建SpotifyCollection的副本
  SpotifyCollection copyWith({
    String? id,
    String? name,
    String? description,
    String? collectionType,
    int? totalItems,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return SpotifyCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      collectionType: collectionType ?? this.collectionType,
      totalItems: totalItems ?? this.totalItems,
      imageUrl: imageUrl ?? this.imageUrl,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
