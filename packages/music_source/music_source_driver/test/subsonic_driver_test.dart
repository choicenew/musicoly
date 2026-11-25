import 'package:flutter_test/flutter_test.dart';
import 'package:music_source_driver/music_source_driver.dart';

void main() {
  group('SubsonicDriver Unit Tests', () {
    late SubsonicDriver driver;

    setUp(() {
      driver = SubsonicDriver();
    });

    test('Initial availability should be false before connect', () async {
      final available = await driver.isAvailable();
      expect(available, isFalse);
    });

    test('Successful connect should set availability to true', () async {
      final success = await driver.connect(
        url: 'https://demo.subsonic.org',
        username: 'demo',
        password: 'demo',
      );
      expect(success, isTrue);

      final available = await driver.isAvailable();
      expect(available, isTrue);
    });

    test('Stream URL format verification', () async {
      await driver.connect(
        url: 'https://demo.subsonic.org',
        username: 'demo',
        password: 'demo',
      );

      final streamUrl = await driver.getAudioStreamUrl('song_123');
      expect(streamUrl, contains('https://demo.subsonic.org/rest/stream'));
      expect(streamUrl, contains('id=song_123'));
    });
  });
}
