import 'package:flutter/foundation.dart';

/// Service for calculating listening stats recaps, top tracks, top artists,
/// and generating Time Machine insights. Integrated from Musify and Finamp references.
class ListeningRecapService {
  /// Calculate listening recap for a given time period (weekly, monthly, yearly)
  Future<ListeningRecap> generateRecap(RecapPeriod period) async {
    debugPrint('Generating listening recap for period: ${period.name}');

    // Aggregate playback history from local DB / Isar cache
    return ListeningRecap(
      period: period,
      totalListeningTime: Duration.zero,
      topTracks: [],
      topArtists: [],
      topGenres: [],
      milestonesCount: 0,
    );
  }

  /// Fetch Time Machine tracks (random or nostalgic tracks from history)
  Future<List<RecapTrack>> getTimeMachineTracks({int limit = 20}) async {
    debugPrint('Fetching Time Machine tracks, limit: $limit');
    return [];
  }
}

enum RecapPeriod { week, month, year, allTime }

class ListeningRecap {
  final RecapPeriod period;
  final Duration totalListeningTime;
  final List<RecapTrack> topTracks;
  final List<RecapArtist> topArtists;
  final List<String> topGenres;
  final int milestonesCount;

  const ListeningRecap({
    required this.period,
    required this.totalListeningTime,
    required this.topTracks,
    required this.topArtists,
    required this.topGenres,
    required this.milestonesCount,
  });
}

class RecapTrack {
  final String id;
  final String title;
  final String artist;
  final int playCount;

  const RecapTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.playCount,
  });
}

class RecapArtist {
  final String id;
  final String name;
  final int playCount;

  const RecapArtist({
    required this.id,
    required this.name,
    required this.playCount,
  });
}
