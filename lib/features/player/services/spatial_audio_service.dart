import 'package:flutter/foundation.dart';

/// 3D Spatial Audio & HRTF Headphone Simulator Service
class SpatialAudioService {
  bool _isSpatialAudioEnabled = false;
  double _roomSize = 0.5; // 0.0 ~ 1.0 (Studio -> Concert Hall)

  bool get isSpatialAudioEnabled => _isSpatialAudioEnabled;
  double get roomSize => _roomSize;

  void toggleSpatialAudio(bool enabled) {
    _isSpatialAudioEnabled = enabled;
    debugPrint('3D Spatial Audio (HRTF) enabled: $_isSpatialAudioEnabled');
  }

  void setRoomSize(double size) {
    _roomSize = size.clamp(0.0, 1.0);
    debugPrint('Spatial audio room size set: $_roomSize');
  }
}
