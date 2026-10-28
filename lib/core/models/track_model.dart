import 'package:flutter/foundation.dart';
import 'audio_source_model.dart';
import 'media_model.dart';
import 'track_interface.dart';

/// Comprehensive Universal Track Model covering Music Tracks, Podcast Episodes, and Audiobook Chapters
@immutable
class TrackModel extends MediaModel implements TrackInterface {
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
  @override
  final String? localPath;
  @override
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

  factory TrackModel.fromInterface(TrackInterface interface) {
    if (interface is TrackModel) return interface;
    return TrackModel(
      id: interface.id,
      platform: interface.platform,
      name: interface.name,
      imageUrl: interface.imageUrl,
      artistIds: interface.artistIds,
      artistNames: interface.artistNames,
      albumId: interface.albumId,
      albumName: interface.albumName,
      durationMs: interface.durationMs,
      isPlayable: interface.isPlayable,
      localPath: interface.localPath,
      isFavorite: interface.isFavorite,
    );
  }

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
