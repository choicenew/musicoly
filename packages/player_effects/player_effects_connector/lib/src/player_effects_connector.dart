import 'package:player_effects_hub/player_effects_hub.dart';
import 'package:player_effects_driver/player_effects_driver.dart';

class PlayerEffectsConnector {
  static final PlayerEffectsHubImpl hub = PlayerEffectsHubImpl();

  static void registerAll() {
    hub.registerDriver(EqualizerDspDriver());
  }
}
