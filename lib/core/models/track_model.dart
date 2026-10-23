import 'package:flutter/foundation.dart';
import 'audio_source_model.dart';
import 'media_model.dart';

/// Comprehensive Universal Track Model covering Music Tracks, Podcast Episodes, and Audiobook Chapters
@immutable
class TrackModel extends MediaModel {
  final List<String> artistIds;
  final List<String> artistNames;
  final String? albumId;
  final String? albumName;
  final int durationMs;
  final bool isPlayable;
  final int? trackNumber;
  final int? discNumber;
  final int? episodeNumber;
  final int? seasonNumber;
  final DateTime? publishDate;
  final int? popularity;
  final bool isExplicit;
  final String? previewUrl;
  final String? audioStreamUrl;
  final String? mimeType;
  final String? localPath;
  final bool isFavorite;
  final String? lyrics;
  final Map<String, dynamic> platformMetadata;

  /// Multiple audio sources (Local file, Plugin A stream, Plugin B stream)
  final List<AudioSourceModel> audioSources;

  /// Lyric source metadata
  final LyricSourceModel? lyricSource;

  const TrackModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.musicTrack,
    super.description,
    super.tags,
    required this.artistIds,
    required this.artistNames,
    this.albumId,
    this.albumName,
    required this.durationMs,
    this.isPlayable = true,
    this.trackNumber,
    this.discNumber,
    this.episodeNumber,
    this.seasonNumber,
    this.publishDate,
    this.popularity,
    this.isExplicit = false,
    this.previewUrl,
    this.audioStreamUrl,
    this.mimeType,
    this.localPath,
    this.isFavorite = false,
    this.lyrics,
    this.platformMetadata = const {},
    this.audioSources = const [],
    this.lyricSource,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'artistIds': artistIds,
        'artistNames': artistNames,
        'albumId': albumId,
        'albumName': albumName,
        'durationMs': durationMs,
        'isPlayable': isPlayable,
        'trackNumber': trackNumber,
        'discNumber': discNumber,
        'episodeNumber': episodeNumber,
        'seasonNumber': seasonNumber,
        'publishDate': publishDate?.toIso8601String(),
        'popularity': popularity,
        'isExplicit': isExplicit,
        'previewUrl': previewUrl,
        'audioStreamUrl': audioStreamUrl,
        'mimeType': mimeType,
        'localPath': localPath,
        'isFavorite': isFavorite,
        'lyrics': lyrics,
        'platformMetadata': platformMetadata,
        'audioSources': audioSources.map((s) => s.toJson()).toList(),
        'lyricSource': lyricSource?.toJson(),
      };

  @override
  TrackModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    List<String>? artistIds,
    List<String>? artistNames,
    String? albumId,
    String? albumName,
    int? durationMs,
    bool? isPlayable,
    int? trackNumber,
    int? discNumber,
    int? episodeNumber,
    int? seasonNumber,
    DateTime? publishDate,
    int? popularity,
    bool? isExplicit,
    String? previewUrl,
    String? audioStreamUrl,
    String? mimeType,
    String? localPath,
    bool? isFavorite,
    String? lyrics,
    Map<String, dynamic>? platformMetadata,
    List<AudioSourceModel>? audioSources,
    LyricSourceModel? lyricSource,
  }) {
    return TrackModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      artistIds: artistIds ?? this.artistIds,
      artistNames: artistNames ?? this.artistNames,
      albumId: albumId ?? this.albumId,
      albumName: albumName ?? this.albumName,
      durationMs: durationMs ?? this.durationMs,
      isPlayable: isPlayable ?? this.isPlayable,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      publishDate: publishDate ?? this.publishDate,
      popularity: popularity ?? this.popularity,
      isExplicit: isExplicit ?? this.isExplicit,
      previewUrl: previewUrl ?? this.previewUrl,
      audioStreamUrl: audioStreamUrl ?? this.audioStreamUrl,
      mimeType: mimeType ?? this.mimeType,
      localPath: localPath ?? this.localPath,
      isFavorite: isFavorite ?? this.isFavorite,
      lyrics: lyrics ?? this.lyrics,
      platformMetadata: platformMetadata ?? this.platformMetadata,
      audioSources: audioSources ?? this.audioSources,
      lyricSource: lyricSource ?? this.lyricSource,
    );
  }
}
