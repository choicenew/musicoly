import 'package:flutter/foundation.dart';
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
