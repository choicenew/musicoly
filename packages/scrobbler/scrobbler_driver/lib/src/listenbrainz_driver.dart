import 'package:scrobbler_protocol/scrobbler_protocol.dart';

class ListenBrainzDriver implements ScrobblerDriver {
  @override
  String get providerId => 'listenbrainz';

  @override
  Future<void> nowPlaying(PlayHistoryEntity history) async {}

  @override
  Future<void> scrobble(PlayHistoryEntity history) async {}
}
