import 'package:flutter/foundation.dart';
import 'package:pyro_music/features/playlist/services/playlist_service.dart';
import 'media_model.dart';

/// Comprehensive Model for Playlists & Queues
@immutable
class PlaylistModel extends MediaModel implements PlaylistInterface {
  final String? ownerId;
  final String? ownerName;
  final bool isPublic;
  final bool isCollaborative;
  @override
  final int totalTracks;
  final Map<String, dynamic> platformMetadata;

  const PlaylistModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.playlist,
    super.description,
    super.tags,
    this.ownerId,
    this.ownerName,
    this.isPublic = true,
    this.isCollaborative = false,
    required this.totalTracks,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'ownerId': ownerId,
        'ownerName': ownerName,
        'isPublic': isPublic,
        'isCollaborative': isCollaborative,
        'totalTracks': totalTracks,
        'platformMetadata': platformMetadata,
      };

  @override
  PlaylistModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    String? ownerId,
    String? ownerName,
    bool? isPublic,
    bool? isCollaborative,
    int? totalTracks,
    Map<String, dynamic>? platformMetadata,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      isPublic: isPublic ?? this.isPublic,
      isCollaborative: isCollaborative ?? this.isCollaborative,
      totalTracks: totalTracks ?? this.totalTracks,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
