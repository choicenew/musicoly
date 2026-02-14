import 'package:flutter/foundation.dart';
import '../interfaces/media/track_interface.dart';
import 'media_model.dart';

/// Model class for tracks
///
/// Implements the TrackInterface and extends MediaModel
@immutable
class TrackModel extends MediaModel implements TrackInterface {
  /// List of artist IDs associated with this track
  @override
  final List<String> artistIds;

  /// List of artist names associated with this track
  @override
  final List<String> artistNames;

  /// Album ID this track belongs to
  @override
  final String? albumId;

  /// Album name this track belongs to
  @override
  final String? albumName;

  /// Duration of the track in milliseconds
  @override
  final int durationMs;

  /// Whether this track is playable
  @override
  final bool isPlayable;

  /// Track number in the album
  @override
  final int? trackNumber;

  /// Disc number in the album
  @override
  final int? discNumber;

  /// Popularity score (0-100)
  @override
  final int? popularity;

  /// Whether this track is explicit
  @override
  final bool isExplicit;

  /// Preview URL for the track (if available)
  @override
  final String? previewUrl;

  /// Local file path (if available)
  @override
  final String? localPath;

  /// Whether this track is marked as favorite
  @override
  final bool isFavorite;

  /// Platform-specific metadata
  @override
  final Map<String, dynamic> platformMetadata;

  /// Create a new track model
  const TrackModel({
    required super.id,
    required super.platform,
    required super.name,
    super.imageUrl,
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
    this.localPath,
    this.isFavorite = false,
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
        'popularity': popularity,
        'isExplicit': isExplicit,
        'previewUrl': previewUrl,
        'localPath': localPath,
        'isFavorite': isFavorite,
        'platformMetadata': platformMetadata,
      };

  @override
  TrackModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
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
    String? localPath,
    Map<String, dynamic>? platformMetadata,
  }) {
    return TrackModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
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
      localPath: localPath ?? this.localPath,
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
      artistIds: interface.artistIds,
      artistNames: interface.artistNames,
      albumId: interface.albumId,
      albumName: interface.albumName,
      durationMs: interface.durationMs,
      isPlayable: interface.isPlayable,
      trackNumber: interface.trackNumber,
      discNumber: interface.discNumber,
      popularity: interface.popularity,
      isExplicit: interface.isExplicit,
      previewUrl: interface.previewUrl,
      localPath: interface.localPath,
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
          popularity == other.popularity &&
          isExplicit == other.isExplicit &&
          previewUrl == other.previewUrl;

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
      popularity.hashCode ^
      isExplicit.hashCode ^
      previewUrl.hashCode;
}
