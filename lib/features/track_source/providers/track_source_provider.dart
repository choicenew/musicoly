import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/track_source/contracts/track_source_contract.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'track_source_provider.freezed.dart';
part 'track_source_provider.g.dart';

/// TrackSource state data class
@freezed
abstract class TrackSourceState with _$TrackSourceState {
  const factory TrackSourceState({
    @Default('') String activePluginId,
    @Default([]) List<String> availablePlugins,
    @Default(SourceQualities.high) SourceQualities quality,
    @Default(SourceCodecs.m4a) SourceCodecs codec,
  }) = _TrackSourceState;
}

/// 音轨源提供者实现 - 使用 TrackSourceManager
@Riverpod(keepAlive: true)
class TrackSourceNotifier extends _$TrackSourceNotifier {
  late final TrackSourceManager _manager;

  @override
  TrackSourceState build() {
    _manager = ServiceRegistry().getService<TrackSourceManager>('track_source_manager')!;
    
    return TrackSourceState(
      activePluginId: _manager.activePluginId,
      availablePlugins: _manager.availablePlugins,
      // 暂时使用默认值，将来可以从 manager 获取
      quality: SourceQualities.high,
      codec: SourceCodecs.m4a,
    );
  }

  void setSource(String pluginId) {
    _manager.setActivePlugin(pluginId);
    state = state.copyWith(activePluginId: pluginId);
  }

  void setQuality(SourceQualities quality) {
    // _manager.setQuality(quality); // 如果 manager 实现了这些接口
    state = state.copyWith(quality: quality);
  }

  void setCodec(SourceCodecs codec) {
    // _manager.setCodec(codec);
    state = state.copyWith(codec: codec);
  }

  /// 搜索音源
  Future<List<SourceInfo>> search(String query) {
    return _manager.search(query);
  }

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackModel track}) {
    return _manager.fetchFromTrack(track: track);
  }
}
