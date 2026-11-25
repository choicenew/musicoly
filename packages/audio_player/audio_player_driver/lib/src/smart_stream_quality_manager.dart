import 'package:flutter/foundation.dart';

enum AudioQuality {
  low('Low (128kbps)', 128),
  medium('Medium (192kbps)', 192),
  high('High (320kbps)', 320),
  lossless('Lossless (FLAC/1411kbps)', 1411);

  final String label;
  final int bitrate;
  const AudioQuality(this.label, this.bitrate);
}

/// SimpMusic & Musify Style Smart Stream Quality Selector & Stream Fallback Manager
class SmartStreamQualityManager {
  AudioQuality _preferredQuality = AudioQuality.high;
  bool _autoFallbackToLowerQuality = true;

  AudioQuality get preferredQuality => _preferredQuality;
  bool get autoFallbackToLowerQuality => _autoFallbackToLowerQuality;

  void setPreferredQuality(AudioQuality quality) {
    _preferredQuality = quality;
    debugPrint('Preferred audio quality set to: ${quality.label}');
  }

  void setAutoFallback(bool fallback) {
    _autoFallbackToLowerQuality = fallback;
    debugPrint('Auto stream quality fallback set to: $_autoFallbackToLowerQuality');
  }

  /// 在当前质量网络卡顿时选出最佳降级码率
  AudioQuality getFallbackQuality(AudioQuality current) {
    switch (current) {
      case AudioQuality.lossless:
        return AudioQuality.high;
      case AudioQuality.high:
        return AudioQuality.medium;
      case AudioQuality.medium:
      case AudioQuality.low:
        return AudioQuality.low;
    }
  }
}
