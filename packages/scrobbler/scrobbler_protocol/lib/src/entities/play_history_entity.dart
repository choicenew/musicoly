import 'package:meta/meta.dart';

@immutable
class PlayHistoryEntity {
  final String trackId;
  final String trackName;
  final String artistName;
  final DateTime timestamp;

  const PlayHistoryEntity({
    required this.trackId,
    required this.trackName,
    required this.artistName,
    required this.timestamp,
  });
}
