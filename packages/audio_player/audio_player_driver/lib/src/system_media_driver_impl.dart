import 'package:audio_player_protocol/audio_player_protocol.dart';

class SystemMediaDriverImpl implements SystemMediaDriver {
  @override
  Future<void> updateMetadata({required String title, required String artist, String? artworkUrl}) async {}

  @override
  Future<void> updatePlaybackState({required bool isPlaying, required Duration position}) async {}
}
