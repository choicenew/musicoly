import 'package:flutter/foundation.dart';
import '../interfaces/media/collection_interface.dart';
import '../interfaces/media/media_interface.dart';
import 'media_model.dart';

/// Model class for generic media collections
///
/// Implements CollectionInterface and extends MediaModel
@immutable
class CollectionModel extends MediaModel implements CollectionInterface {
  @override
  final String collectionType;

  @override
  final int totalItems;

  @override
  final Map<String, dynamic> platformMetadata;

  /// Create a new collection model
  const CollectionModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.collection,
    super.description,
    super.tags,
    required this.collectionType,
    required this.totalItems,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'collectionType': collectionType,
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
    String? collectionType,
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
      collectionType: collectionType ?? this.collectionType,
      totalItems: totalItems ?? this.totalItems,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CollectionModel &&
          runtimeType == other.runtimeType &&
          collectionType == other.collectionType &&
          totalItems == other.totalItems;

  @override
  int get hashCode =>
      super.hashCode ^
      collectionType.hashCode ^
      totalItems.hashCode;
}
