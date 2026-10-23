import 'package:flutter/foundation.dart';
import 'base_service.dart';

/// Playback service interface for music playback functionality
///
/// Provides methods for controlling music playback across platforms
abstract class PlaybackService extends BaseService {
  /// Play a specific track by ID
  Future<void> playTrack(String trackId);

  /// Pause the current playback
  Future<void> pausePlayback();

  /// Resume the current playback
  Future<void> resumePlayback();

  /// Seek to a specific position in the current track
  Future<void> seekToPosition(int positionMs);

  /// Set the playback volume
  Future<void> setVolume(double volume);

  /// Get the current playback state
  Future<Map<String, dynamic>> getPlaybackState();

  /// Skip to the next track
  Future<void> nextTrack();

  /// Go back to the previous track
  Future<void> previousTrack();
}
