import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';

export 'package:pyro_music/features/plugin/plugin_source_contract.dart' show AudioStreamInfo;

enum SourceQualities { low, medium, high, lossless }

enum SourceCodecs { mp3, m4a, flac, aac, ogg, opus }

class SourceInfo {
  final String id;
  final String title;
  final String artist;
  final String? album;
  final String? url;
  final String thumbnailUrl;
  final Duration duration;
  final SourceQualities quality;
  final SourceCodecs codec;

  const SourceInfo({
    required this.id,
    required this.title,
    required this.artist,
    this.album,
    this.url,
    this.thumbnailUrl = '',
    this.duration = Duration.zero,
    this.quality = SourceQualities.high,
    this.codec = SourceCodecs.m4a,
  });
}

class SourcedTrack {
  final TrackModel track;
  final String sourceUrl;
  final Map<String, String>? headers;
  final SourceQualities quality;
  final SourceCodecs codec;

  const SourcedTrack({
    required this.track,
    required this.sourceUrl,
    this.headers,
    this.quality = SourceQualities.high,
    this.codec = SourceCodecs.m4a,
  });
}

abstract class TrackSourceService extends BaseService {
  Future<List<SourceInfo>> search(String query);
  Future<SourcedTrack> fetchFromTrack({required TrackModel track});
}

abstract class TrackSourceManager extends BaseService {
  String get activePluginId;
  List<String> get availablePlugins;
  void setActivePlugin(String pluginId);
  TrackSourceService? get activePlugin;
  Future<List<SourceInfo>> search(String query);
  Future<SourcedTrack> fetchFromTrack({required TrackModel track});
}

/// Universal Track Source Contract ABI
abstract class TrackSourceContract {
  String get pluginId;
  String get pluginName;
  String get version;
  String? get description;

  Future<List<HomeSectionModel>> fetchHomeSections();
  Future<List<MediaModel>> search(String query, {List<String>? types});
  Future<AudioStreamInfo> fetchAudioStream(String trackId);
}
