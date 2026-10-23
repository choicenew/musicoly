import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/track_interface.dart';

/// Spotify音轨模型 - 实现TrackInterface接口
@immutable
class SpotifyTrack implements TrackInterface {
  /// 构造函数
  const SpotifyTrack({
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

  /// 从JSON创建SpotifyTrack实例
  factory SpotifyTrack.fromJson(Map<String, dynamic> json) {
    final artists =
        (json['artists'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final album = json['album'] as Map<String, dynamic>?;
    final images = album?['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    return SpotifyTrack(
      id: json['id'] as String,
      name: json['name'] as String,
      artistIds: artists.map((a) => a['id'] as String).toList(),
      artistNames: artists.map((a) => a['name'] as String).toList(),
      albumId: album?['id'] as String?,
      albumName: album?['name'] as String?,
      durationMs: json['duration_ms'] as int? ?? 0,
      isPlayable: json['is_playable'] as bool? ?? true,
      trackNumber: json['track_number'] as int?,
      discNumber: json['disc_number'] as int?,
      popularity: json['popularity'] as int?,
      isExplicit: json['explicit'] as bool? ?? false,
      previewUrl: json['preview_url'] as String?,
      imageUrl: imageUrl,
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
  String get platform => 'spotify';

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

  /// 创建SpotifyTrack的副本
  SpotifyTrack copyWith({
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
    return SpotifyTrack(
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
