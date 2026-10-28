import 'package:flutter/foundation.dart';
import 'artist_model.dart';
import 'track_model.dart';

@immutable
class TrackPlayStatsModel {
  final String trackId;
  final int playCount;
  final DateTime? lastPlayedAt;
  final TrackModel? track;

  const TrackPlayStatsModel({
    required this.trackId,
    required this.playCount,
    this.lastPlayedAt,
    this.track,
  });
}

@immutable
class ArtistStatsModel {
  final String id;
  final ArtistModel artist;
  final int playCount;
  final DateTime firstPlayed;
  final DateTime lastPlayed;
  final int totalPlayDuration;
  final String platform;

  const ArtistStatsModel({
    required this.id,
    required this.artist,
    required this.playCount,
    required this.firstPlayed,
    required this.lastPlayed,
    required this.totalPlayDuration,
    required this.platform,
  });
}

@immutable
class PlayStatsModel {
  final String id;
  final TrackModel track;
  final int playCount;
  final DateTime firstPlayed;
  final DateTime lastPlayed;
  final int playDuration;
  final bool isCompletePlay;
  final int skipCount;
  final String platform;

  const PlayStatsModel({
    required this.id,
    required this.track,
    required this.playCount,
    required this.firstPlayed,
    required this.lastPlayed,
    required this.playDuration,
    required this.isCompletePlay,
    required this.skipCount,
    required this.platform,
  });
}
