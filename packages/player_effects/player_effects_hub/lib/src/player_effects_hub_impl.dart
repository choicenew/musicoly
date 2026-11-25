import 'package:player_effects_protocol/player_effects_protocol.dart';

class PlayerEffectsHubImpl {
  final List<AudioEffectDriver> _drivers = [];

  void registerDriver(AudioEffectDriver driver) {
    _drivers.add(driver);
  }

  List<AudioEffectDriver> get drivers => List.unmodifiable(_drivers);
}
