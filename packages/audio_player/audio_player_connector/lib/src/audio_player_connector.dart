import 'package:audio_player_hub/audio_player_hub.dart';
import 'package:audio_player_driver/audio_player_driver.dart';

class AudioPlayerConnector {
  static void registerAll() {
    final hub = AudioPlayerHub();

    final playerDriver = JustAudioDriverImpl();
    final systemDriver = SystemMediaDriverImpl();

    hub.registerPlayerDriver(playerDriver);
    hub.registerSystemMediaDriver(systemDriver);
  }
}
