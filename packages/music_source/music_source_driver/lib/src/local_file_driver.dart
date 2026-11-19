import 'package:music_source_protocol/music_source_protocol.dart';

class LocalFileDriver implements TrackSourceDriver {
  @override
  String get platformId => 'local';

  @override
  String get platformName => 'Local Files';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<TrackEntity?> getTrackDetails(String trackId) async {
    return TrackEntity(
      id: trackId,
      platform: platformId,
      name: 'Local Audio File',
      durationMs: 240000,
    );
  }

  @override
  Future<String?> getAudioStreamUrl(String trackId) async => trackId;

  @override
  Future<void> dispose() async {}
}
