import 'package:flutter/foundation.dart';
import 'media_model.dart';

@immutable
class CollectionModel extends MediaModel {
  final List<String> itemIds;
  final int totalItems;
  final Map<String, dynamic> platformMetadata;

  const CollectionModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.collection,
    super.description,
    super.tags,
    required this.itemIds,
    required this.totalItems,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'itemIds': itemIds,
        'totalItems': totalItems,
        'platformMetadata': platformMetadata,
      };

  @override
  CollectionModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    List<String>? itemIds,
    int? totalItems,
    Map<String, dynamic>? platformMetadata,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      itemIds: itemIds ?? this.itemIds,
      totalItems: totalItems ?? this.totalItems,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
