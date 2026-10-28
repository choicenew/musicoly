import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';

/// Audio stream metadata returned by a plugin
class AudioStreamInfo {
  final String url;
  final Map<String, String>? headers;
  final String? mimeType;
  final int? bitrate;
  final String? quality;

  const AudioStreamInfo({
    required this.url,
    this.headers,
    this.mimeType,
    this.bitrate,
    this.quality,
  });
}

/// Open Standard Plugin Contract ABI
/// All dynamic external plugins must implement this interface
abstract class PluginSourceContract {
  /// Unique identifier of the plugin (e.g., 'org.pyromusic.local', 'org.pyromusic.yt')
  String get pluginId;

  /// Human-readable name of the plugin
  String get pluginName;

  /// Semantic version of the plugin
  String get version;

  /// Plugin description
  String? get description;

  /// Fetch dynamic home screen sections provided by this plugin
  Future<List<HomeSectionModel>> fetchHomeSections();

  /// Search media items across this plugin
  Future<List<MediaModel>> search(String query, {List<String>? types});

  /// Fetch playable audio stream information for a track
  Future<AudioStreamInfo> fetchAudioStream(String trackId);
}
