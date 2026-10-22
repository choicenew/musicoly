import 'package:flutter/foundation.dart';
import '../interfaces/media/media_interface.dart';
import 'base_model.dart';

/// Base class for all media models in the application
///
/// Implements the MediaInterface and extends BaseModel
@immutable
abstract class MediaModel extends BaseModel implements MediaInterface {
  /// Name or title of the media
  @override
  final String name;

  @override
  final String? imageUrl;

  @override
  final MediaType mediaType;

  @override
  final String? description;

  @override
  final List<String>? tags;

  /// Create a new media model
  const MediaModel({
    required super.id,
    required super.platform,
    required this.name,
    this.imageUrl,
    this.mediaType = MediaType.musicTrack,
    this.description,
    this.tags,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'name': name,
        'imageUrl': imageUrl,
        'mediaType': mediaType.name,
        'description': description,
        'tags': tags,
      };

  @override
  MediaModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is MediaModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          mediaType == other.mediaType &&
          description == other.description &&
          listEquals(tags, other.tags);

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      mediaType.hashCode ^
      description.hashCode ^
      tags.hashCode;
}
