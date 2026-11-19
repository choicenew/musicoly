import '../entities/play_history_entity.dart';

abstract class ScrobblerDriver {
  String get providerId;
  Future<void> scrobble(PlayHistoryEntity history);
  Future<void> nowPlaying(PlayHistoryEntity history);
}
