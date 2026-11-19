import 'package:meta/meta.dart';

@immutable
class ListeningStatsEntity {
  final int totalTracksPlayed;
  final int totalListeningMinutes;
  final Map<String, int> topArtistsCount;

  const ListeningStatsEntity({
    this.totalTracksPlayed = 0,
    this.totalListeningMinutes = 0,
    this.topArtistsCount = const {},
  });
}
