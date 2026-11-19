import 'package:scrobbler_protocol/scrobbler_protocol.dart';

class ScrobblerHub {
  static final ScrobblerHub _instance = ScrobblerHub._internal();
  factory ScrobblerHub() => _instance;
  ScrobblerHub._internal();

  final List<ScrobblerDriver> _drivers = [];

  void registerDriver(ScrobblerDriver driver) {
    _drivers.add(driver);
  }

  Future<void> notifyNowPlaying(PlayHistoryEntity history) async {
    for (final driver in _drivers) {
      try {
        await driver.nowPlaying(history);
      } catch (_) {}
    }
  }

  Future<void> submitScrobble(PlayHistoryEntity history) async {
    for (final driver in _drivers) {
      try {
        await driver.scrobble(history);
      } catch (_) {}
    }
  }
}
