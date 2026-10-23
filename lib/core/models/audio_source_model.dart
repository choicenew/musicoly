import 'package:flutter/foundation.dart';

/// Audio Source Model for Local files, Plugin Stream Sources & Fallback Streams
@immutable
class AudioSourceModel {
  final String sourceId; // 'local', 'org.pyromusic.yt', 'org.pyromusic.subsonic'
  final String url; // file://... or https://...
  final Map<String, String>? headers;
  final String? quality; // 'low', 'medium', 'high', 'lossless'
  final String? mimeType;
  final int? bitrate;
  final bool isAvailable;

  const AudioSourceModel({
    required this.sourceId,
    required this.url,
    this.headers,
    this.quality = 'high',
    this.mimeType,
    this.bitrate,
    this.isAvailable = true,
  });

  Map<String, dynamic> toJson() => {
        'sourceId': sourceId,
        'url': url,
        'headers': headers,
        'quality': quality,
        'mimeType': mimeType,
        'bitrate': bitrate,
        'isAvailable': isAvailable,
      };
}

/// Lyric Source Model for Local LRC files, Embedded tags, and Online Plugins
@immutable
class LyricSourceModel {
  final String? localPath;
  final String? rawLrc;
  final String? pluginId;
  final bool isSynced;

  const LyricSourceModel({
    this.localPath,
    this.rawLrc,
    this.pluginId,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() => {
        'localPath': localPath,
        'rawLrc': rawLrc,
        'pluginId': pluginId,
        'isSynced': isSynced,
      };
}
