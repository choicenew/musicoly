import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/core/storage/isar/entities/index.dart';

/// 本地音源插件 - 负责从本地数据库和文件系统读取音源
class LocalTrackSourceService extends TrackSourceService {
  final Isar _isar;

  LocalTrackSourceService(this._isar);

  @override
  String get pluginId => 'local';

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
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track}) async {
    // 检查是否有本地路径
    if (track.previewUrl != null && track.previewUrl!.startsWith('file://')) {
      return SourcedTrackModel(
        track: track,
        sourceId: pluginId,
        sourceInfo: SourceInfoModel(
          id: track.id,
          title: track.name,
          artist: track.artistNames.join(', '),
          thumbnailUrl: track.imageUrl ?? '',
          duration: Duration(milliseconds: track.durationMs),
          sourceId: pluginId,
          url: track.previewUrl,
        ),
        siblings: [],
        codec: SourceCodecs.m4a, // 默认 codec，实际应根据文件判断
      );
    }

    // 从数据库查找
    final trackEntity = await _isar.trackEntitys.filter().trackIdEqualTo(track.id).findFirst();
    if (trackEntity != null && trackEntity.localPath != null) {
      final path = trackEntity.localPath!;
      return SourcedTrackModel(
        track: track,
        sourceId: pluginId,
        sourceInfo: SourceInfoModel(
          id: track.id,
          title: track.name,
          artist: track.artistNames.join(', '),
          thumbnailUrl: track.imageUrl ?? '',
          duration: Duration(milliseconds: track.durationMs),
          sourceId: pluginId,
          url: 'file://$path',
        ),
        siblings: [],
        codec: _determineCodec(path),
      );
    }

    throw Exception('未找到本地音源: ${track.name}');
  }

  @override
  Future<List<SourceInfo>> search(String query) async {
    // 从本地数据库搜索
    final results = await _isar.trackEntitys
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .artistNamesElementContains(query, caseSensitive: false)
        .findAll();

    return results.map((e) => SourceInfoModel(
      id: e.trackId,
      title: e.name,
      artist: e.artistNames?.join(', ') ?? '',
      thumbnailUrl: e.imageUrl ?? '',
      duration: Duration(milliseconds: e.durationMs),
      sourceId: pluginId,
      url: e.localPath != null ? 'file://${e.localPath}' : null,
    )).toList();
  }

  SourceCodecs _determineCodec(String path) {
    if (path.endsWith('.mp3')) return SourceCodecs.mp3;
    if (path.endsWith('.m4a')) return SourceCodecs.m4a;
    if (path.endsWith('.flac')) return SourceCodecs.flac;
    if (path.endsWith('.wav')) return SourceCodecs.wav;
    if (path.endsWith('.ogg') || path.endsWith('.opus')) return SourceCodecs.opus;
    return SourceCodecs.m4a;
  }
}
