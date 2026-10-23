import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/track_interface.dart';

/// YouTube Music音轨模型 - 实现TrackInterface接口
@immutable
class YouTubeTrack implements TrackInterface {
  /// 构造函数
  const YouTubeTrack({
    required this.id,
    required this.name,
    required this.artistIds,
    required this.artistNames,
    this.albumId,
    this.albumName,
    required this.durationMs,
    this.isPlayable = true,
    this.trackNumber,
    this.discNumber,
    this.popularity,
    this.isExplicit = false,
    this.previewUrl,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubeTrack实例
  factory YouTubeTrack.fromJson(Map<String, dynamic> json) {
    final artists =
        (json['artists'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final album = json['album'] as Map<String, dynamic>?;

    return YouTubeTrack(
      id: json['id'] as String,
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      artistIds: artists.map((a) => a['id'] as String? ?? '').toList(),
      artistNames: artists.map((a) => a['name'] as String? ?? '').toList(),
      albumId: album?['id'] as String?,
      albumName: album?['name'] as String?,
      durationMs: json['duration_ms'] as int? ?? json['lengthMs'] as int? ?? 0,
      isPlayable: json['isPlayable'] as bool? ?? true,
      trackNumber: json['trackNumber'] as int?,
      discNumber: json['discNumber'] as int?,
      popularity: json['popularity'] as int?,
      isExplicit: json['explicit'] as bool? ?? false,
      previewUrl: json['previewUrl'] as String?,
      imageUrl: json['thumbnailUrl'] as String? ?? json['thumbnail'] as String?,
      platformMetadata: json,
    );
  }

  @override
  final String id;

  @override
  final String name;

  @override
  final List<String> artistIds;

  @override
  final List<String> artistNames;

  @override
  final String? albumId;

  @override
  final String? albumName;

  @override
  final int durationMs;

  @override
  final bool isPlayable;

  @override
  final int? trackNumber;

  @override
  final int? discNumber;

  @override
  final int? popularity;

  @override
  final bool isExplicit;

  @override
  final String? previewUrl;

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
      'artist_ids': artistIds,
      'artist_names': artistNames,
      'album_id': albumId,
      'album_name': albumName,
      'duration_ms': durationMs,
      'is_playable': isPlayable,
      'track_number': trackNumber,
      'disc_number': discNumber,
      'popularity': popularity,
      'is_explicit': isExplicit,
      'preview_url': previewUrl,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubeTrack的副本
  YouTubeTrack copyWith({
    String? id,
    String? name,
    List<String>? artistIds,
    List<String>? artistNames,
    String? albumId,
    String? albumName,
    int? durationMs,
    bool? isPlayable,
    int? trackNumber,
    int? discNumber,
    int? popularity,
    bool? isExplicit,
    String? previewUrl,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubeTrack(
      id: id ?? this.id,
      name: name ?? this.name,
      artistIds: artistIds ?? this.artistIds,
      artistNames: artistNames ?? this.artistNames,
      albumId: albumId ?? this.albumId,
      albumName: albumName ?? this.albumName,
      durationMs: durationMs ?? this.durationMs,
      isPlayable: isPlayable ?? this.isPlayable,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      popularity: popularity ?? this.popularity,
      isExplicit: isExplicit ?? this.isExplicit,
      previewUrl: previewUrl ?? this.previewUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
