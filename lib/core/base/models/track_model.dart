import 'package:flutter/foundation.dart';
import '../interfaces/media/media_interface.dart';
import '../interfaces/media/track_interface.dart';
import 'media_model.dart';

/// Model class for music tracks, podcast episodes, and custom audio items
///
/// Implements TrackInterface and extends MediaModel
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

  @override
  final int? trackNumber;

  @override
  final int? discNumber;

  @override
  final int? episodeNumber;

  @override
  final int? seasonNumber;

  @override
  final DateTime? publishDate;

  @override
  final int? popularity;

  @override
  final bool isExplicit;

  @override
  final String? previewUrl;

  @override
  final String? audioStreamUrl;

  @override
  final String? mimeType;

  @override
  final String? localPath;

  @override
  final bool isFavorite;

  @override
  final String? lyrics;

  @override
  final Map<String, dynamic> platformMetadata;

  /// Create a new track model
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
    );
  }

  /// Create a TrackModel from a TrackInterface
  factory TrackModel.fromInterface(TrackInterface interface) {
    if (interface is TrackModel) return interface;

    return TrackModel(
      id: interface.id,
      platform: interface.platform,
      name: interface.name,
      imageUrl: interface.imageUrl,
      mediaType: interface.mediaType,
      description: interface.description,
      tags: interface.tags,
      artistIds: interface.artistIds,
      artistNames: interface.artistNames,
      albumId: interface.albumId,
      albumName: interface.albumName,
      durationMs: interface.durationMs,
      isPlayable: interface.isPlayable,
      trackNumber: interface.trackNumber,
      discNumber: interface.discNumber,
      episodeNumber: interface.episodeNumber,
      seasonNumber: interface.seasonNumber,
      publishDate: interface.publishDate,
      popularity: interface.popularity,
      isExplicit: interface.isExplicit,
      previewUrl: interface.previewUrl,
      audioStreamUrl: interface.audioStreamUrl,
      mimeType: interface.mimeType,
      localPath: interface.localPath,
      isFavorite: interface.isFavorite,
      lyrics: interface.lyrics,
      platformMetadata: interface.platformMetadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is TrackModel &&
          runtimeType == other.runtimeType &&
          artistIds == other.artistIds &&
          artistNames == other.artistNames &&
          albumId == other.albumId &&
          albumName == other.albumName &&
          durationMs == other.durationMs &&
          isPlayable == other.isPlayable &&
          trackNumber == other.trackNumber &&
          discNumber == other.discNumber &&
          episodeNumber == other.episodeNumber &&
          seasonNumber == other.seasonNumber &&
          publishDate == other.publishDate &&
          popularity == other.popularity &&
          isExplicit == other.isExplicit &&
          previewUrl == other.previewUrl &&
          audioStreamUrl == other.audioStreamUrl &&
          mimeType == other.mimeType &&
          localPath == other.localPath &&
          isFavorite == other.isFavorite &&
          lyrics == other.lyrics;

  @override
  int get hashCode =>
      super.hashCode ^
      artistIds.hashCode ^
      artistNames.hashCode ^
      albumId.hashCode ^
      albumName.hashCode ^
      durationMs.hashCode ^
      isPlayable.hashCode ^
      trackNumber.hashCode ^
      discNumber.hashCode ^
      episodeNumber.hashCode ^
      seasonNumber.hashCode ^
      publishDate.hashCode ^
      popularity.hashCode ^
      isExplicit.hashCode ^
      previewUrl.hashCode ^
      audioStreamUrl.hashCode ^
      mimeType.hashCode ^
      localPath.hashCode ^
      isFavorite.hashCode ^
      lyrics.hashCode;
}
