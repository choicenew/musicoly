import 'package:scrobbler_protocol/scrobbler_protocol.dart';

class LocalIsarStatsDriver implements ScrobblerDriver {
  @override
  String get providerId => 'local_isar';

  @override
  Future<void> nowPlaying(PlayHistoryEntity history) async {}

  @override
  Future<void> scrobble(PlayHistoryEntity history) async {}
}
