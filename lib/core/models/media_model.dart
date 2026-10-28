import 'package:flutter/foundation.dart';
import 'base_model.dart';

enum MediaType {
  musicTrack,
  podcastEpisode,
  audiobookChapter,
  album,
  podcastShow,
  audiobook,
  artist,
  podcastHost,
  playlist,
  collection,
  custom;

  String get value => name;

  static MediaType fromString(String? type) {
    if (type == null) return MediaType.musicTrack;
    return MediaType.values.firstWhere(
      (e) => e.name == type || e.name.toLowerCase() == type.toLowerCase(),
      orElse: () => MediaType.musicTrack,
    );
  }
}

/// Base class for all media models
@immutable
abstract class MediaModel extends BaseModel {
  final String name;
  final String? imageUrl;
  final MediaType mediaType;
  final String? description;
  final List<String>? tags;

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
}
