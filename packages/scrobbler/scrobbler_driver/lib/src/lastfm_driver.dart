import 'package:scrobbler_protocol/scrobbler_protocol.dart';

class LastFmDriver implements ScrobblerDriver {
  @override
  String get providerId => 'lastfm';

  @override
  Future<void> nowPlaying(PlayHistoryEntity history) async {}

  @override
  Future<void> scrobble(PlayHistoryEntity history) async {}
}
