import 'package:flutter/foundation.dart';
import 'track_model.dart';

class SourceInfo {
  final String pluginId;
  final String quality;
  final int? bitrate;
  final bool isAvailable;

  const SourceInfo({
    required this.pluginId,
    required this.quality,
    this.bitrate,
    this.isAvailable = true,
  });
}

@immutable
class CompositeTrackModel {
  final String canonicalId;
  final String primaryTitle;
  final String primaryArtist;
  final TrackModel primaryTrack;
  final List<SourceInfo> availableSources;

  const CompositeTrackModel({
    required this.canonicalId,
    required this.primaryTitle,
    required this.primaryArtist,
    required this.primaryTrack,
    this.availableSources = const [],
  });

  CompositeTrackModel copyWith({
    String? canonicalId,
    String? primaryTitle,
    String? primaryArtist,
    TrackModel? primaryTrack,
    List<SourceInfo>? availableSources,
  }) {
    return CompositeTrackModel(
      canonicalId: canonicalId ?? this.canonicalId,
      primaryTitle: primaryTitle ?? this.primaryTitle,
      primaryArtist: primaryArtist ?? this.primaryArtist,
      primaryTrack: primaryTrack ?? this.primaryTrack,
      availableSources: availableSources ?? this.availableSources,
    );
  }
}
