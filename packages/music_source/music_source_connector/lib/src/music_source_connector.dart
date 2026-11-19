import 'package:music_source_hub/music_source_hub.dart';
import 'package:music_source_driver/music_source_driver.dart';

class MusicSourceConnector {
  static void registerAll() {
    final hub = PlatformRegistryHub();

    final spotifyDriver = SpotifyDriver();
    final youtubeDriver = YouTubeMusicDriver();
    final localDriver = LocalFileDriver();

    hub.registerTrackDriver(spotifyDriver);
    hub.registerSearchDriver(spotifyDriver);
    hub.registerLyricsDriver(spotifyDriver);

    hub.registerTrackDriver(youtubeDriver);
    hub.registerSearchDriver(youtubeDriver);

    hub.registerTrackDriver(localDriver);
  }
}
