import 'package:scrobbler_hub/scrobbler_hub.dart';
import 'package:scrobbler_driver/scrobbler_driver.dart';

class ScrobblerConnector {
  static void registerAll() {
    final hub = ScrobblerHub();

    hub.registerDriver(LastFmDriver());
    hub.registerDriver(ListenBrainzDriver());
    hub.registerDriver(LocalIsarStatsDriver());
  }
}
