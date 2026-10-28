import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/album_interface.dart';

/// YouTube Music专辑模型 - 实现AlbumInterface接口
@immutable
class YouTubeAlbum implements AlbumInterface {
  /// 构造函数
  const YouTubeAlbum({
    required this.id,
    required this.name,
    required this.artistIds,
    required this.artistNames,
    this.releaseDate,
    required this.totalTracks,
    this.albumType,
    this.genres,
    this.popularity,
    this.imageUrl,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubeAlbum实例
  factory YouTubeAlbum.fromJson(Map<String, dynamic> json) {
    final artistId = json['artistId'] as String?;
    final artistName = json['artistName'] as String?;

    List<String> artistIds = [];
    List<String> artistNames = [];

    if (artistId != null) artistIds.add(artistId);
    if (artistName != null) artistNames.add(artistName);

    // 处理可能的多个艺术家情况
    final artists = json['artists'] as List?;
    if (artists != null && artists.isNotEmpty) {
      artistIds = artists.map((a) => a['id'] as String? ?? '').toList();
      artistNames = artists.map((a) => a['name'] as String? ?? '').toList();
    }

    DateTime? releaseDate;
    final releaseDateStr = json['releaseDate'] as String?;
    if (releaseDateStr != null) {
      try {
        releaseDate = DateTime.parse(releaseDateStr);
      } catch (e) {
        // 处理不同格式的日期
        final parts = releaseDateStr.split('-');
        if (parts.length == 1) {
          // 只有年份
          releaseDate = DateTime(int.parse(parts[0]));
        } else if (parts.length == 2) {
          // 年份和月份
          releaseDate = DateTime(int.parse(parts[0]), int.parse(parts[1]));
        }
      }
    }

    return YouTubeAlbum(
      id: json['id'] as String,
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      artistIds: artistIds,
      artistNames: artistNames,
      releaseDate: releaseDate,
      totalTracks:
          json['trackCount'] as int? ?? (json['tracks'] as List?)?.length ?? 0,
      albumType: json['albumType'] as String?,
      genres: (json['genres'] as List?)?.cast<String>(),
      popularity: json['popularity'] as int?,
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
  final DateTime? releaseDate;

  @override
  final int totalTracks;

  @override
  final String? albumType;

  @override
  final List<String>? genres;

  @override
  final int? popularity;

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
      'release_date': releaseDate?.toIso8601String(),
      'total_tracks': totalTracks,
      'album_type': albumType,
      'genres': genres,
      'popularity': popularity,
      'image_url': imageUrl,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubeAlbum的副本
  YouTubeAlbum copyWith({
    String? id,
    String? name,
    List<String>? artistIds,
    List<String>? artistNames,
    DateTime? releaseDate,
    int? totalTracks,
    String? albumType,
    List<String>? genres,
    int? popularity,
    String? imageUrl,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubeAlbum(
      id: id ?? this.id,
      name: name ?? this.name,
      artistIds: artistIds ?? this.artistIds,
      artistNames: artistNames ?? this.artistNames,
      releaseDate: releaseDate ?? this.releaseDate,
      totalTracks: totalTracks ?? this.totalTracks,
      albumType: albumType ?? this.albumType,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      imageUrl: imageUrl ?? this.imageUrl,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
