import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';

export 'package:pyro_music/features/plugin/plugin_source_contract.dart' show AudioStreamInfo;

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
