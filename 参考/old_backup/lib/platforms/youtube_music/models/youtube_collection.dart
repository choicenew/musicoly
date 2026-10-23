import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/collection_interface.dart';

/// YouTube Music集合模型 - 实现CollectionInterface接口
@immutable
class YouTubeCollection implements CollectionInterface {
  /// 构造函数
  const YouTubeCollection({
    required this.id,
    required this.name,
    this.description,
    required this.collectionType,
    required this.totalItems,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubeCollection实例
  factory YouTubeCollection.fromJson(Map<String, dynamic> json) {
    return YouTubeCollection(
      id: json['id'] as String,
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      description: json['description'] as String?,
      collectionType: json['type'] as String? ?? 'unknown',
      totalItems: json['itemCount'] as int? ?? json['total'] as int? ?? 0,
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
  final String collectionType;

  @override
  final int totalItems;

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
      'collection_type': collectionType,
      'total_items': totalItems,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubeCollection的副本
  YouTubeCollection copyWith({
    String? id,
    String? name,
    String? description,
    String? collectionType,
    int? totalItems,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubeCollection(
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
