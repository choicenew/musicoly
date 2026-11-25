import 'package:lyric_hub/lyric_hub.dart';
import 'package:lyric_driver/lyric_driver.dart';

class LyricConnector {
  static final LyricHubImpl hub = LyricHubImpl();

  static void initialize() {
    hub.registerDriver(LrcParserDriver());
  }
}
