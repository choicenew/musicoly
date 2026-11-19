import '../entities/track_entity.dart';

abstract class TrackSourceDriver {
  String get platformId;
  String get platformName;
  Future<void> initialize();
  Future<bool> isAvailable();
  Future<TrackEntity?> getTrackDetails(String trackId);
  Future<String?> getAudioStreamUrl(String trackId);
  Future<void> dispose();
}
