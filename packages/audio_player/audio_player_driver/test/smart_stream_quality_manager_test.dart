import 'package:flutter_test/flutter_test.dart';
import 'package:audio_player_driver/audio_player_driver.dart';

void main() {
  group('SmartStreamQualityManager Unit Tests', () {
    late SmartStreamQualityManager manager;

    setUp(() {
      manager = SmartStreamQualityManager();
    });

    test('Default preferred quality should be High', () {
      expect(manager.preferredQuality, equals(AudioQuality.high));
    });

    test('Quality fallback from Lossless should return High', () {
      final fallback = manager.getFallbackQuality(AudioQuality.lossless);
      expect(fallback, equals(AudioQuality.high));
    });

    test('Quality fallback from High should return Medium', () {
      final fallback = manager.getFallbackQuality(AudioQuality.high);
      expect(fallback, equals(AudioQuality.medium));
    });
  });
}
