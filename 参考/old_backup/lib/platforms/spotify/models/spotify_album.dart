import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/media/album_interface.dart';

/// Spotify专辑模型 - 实现AlbumInterface接口
@immutable
class SpotifyAlbum implements AlbumInterface {
  /// 构造函数
  const SpotifyAlbum({
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

  /// 从JSON创建SpotifyAlbum实例
  factory SpotifyAlbum.fromJson(Map<String, dynamic> json) {
    final artists =
        (json['artists'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final images = json['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    DateTime? releaseDate;
    final releaseDateStr = json['release_date'] as String?;
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

    return SpotifyAlbum(
      id: json['id'] as String,
      name: json['name'] as String,
      artistIds: artists.map((a) => a['id'] as String).toList(),
      artistNames: artists.map((a) => a['name'] as String).toList(),
      releaseDate: releaseDate,
      totalTracks: json['total_tracks'] as int? ?? 0,
      albumType: json['album_type'] as String?,
      genres: (json['genres'] as List?)?.cast<String>(),
      popularity: json['popularity'] as int?,
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
  String get platform => 'spotify';

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

  /// 创建SpotifyAlbum的副本
  SpotifyAlbum copyWith({
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
    return SpotifyAlbum(
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
