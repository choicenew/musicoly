import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';
import 'package:pyro_music/core/database/isar/entities/index.dart';

/// 本地音源插件 - 负责从本地数据库和文件系统读取音源
class LocalTrackSourceService extends BaseService implements PluginSourceContract {
  final Isar _isar;

  LocalTrackSourceService(this._isar);

  @override
  String get pluginId => 'org.pyromusic.local';

  @override
  String get pluginName => 'Local Track Source';

  @override
  String get version => '1.0.0';

  @override
  String? get description => 'Local music database track source';

  @override
  String get serviceId => 'track_source_local';

  @override
  String get serviceName => '本地音源';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  @override
  Future<void> initialize() async {}

  @override
  Future<List<HomeSectionModel>> fetchHomeSections() async => [];

  @override
  Future<List<MediaModel>> search(String query, {List<String>? types}) async {
    final results = await _isar.trackEntitys
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .artistNamesElementContains(query, caseSensitive: false)
        .findAll();

    return results.map((e) => e.toModel()).toList();
  }

  @override
  Future<AudioStreamInfo> fetchAudioStream(String trackId) async {
    final trackEntity = await _isar.trackEntitys.filter().trackIdEqualTo(trackId).findFirst();
    if (trackEntity != null && trackEntity.localPath != null) {
      return AudioStreamInfo(url: 'file://${trackEntity.localPath}');
    }
    throw Exception('未找到本地音源文件: $trackId');
  }
}
