import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/track_source/contracts/track_source_contract.dart';
import 'package:pyro_music/features/track_source/providers/track_source_provider.dart';

final trackSourceControllerProvider = Provider((ref) => TrackSourceController(ref));

/// 音轨源控制器
/// 负责处理音轨源的用户交互逻辑
class TrackSourceController {
  final Ref _ref;

  TrackSourceController(this._ref);

  TrackSourceNotifier get _notifier => _ref.read(trackSourceProvider.notifier);
  TrackSourceState get _state => _ref.read(trackSourceProvider);

  /// 获取当前音频源插件ID
  String get activePluginId => _state.activePluginId;

  /// 获取当前音频质量
  SourceQualities get quality => _state.quality;

  /// 获取当前音频编解码器
  SourceCodecs get codec => _state.codec;

  /// 设置音频源插件
  void setSource(String pluginId) {
    _notifier.setSource(pluginId);
  }

  /// 设置音频质量
  void setQuality(SourceQualities quality) {
    _notifier.setQuality(quality);
  }

  /// 设置音频编解码器
  void setCodec(SourceCodecs codec) {
    _notifier.setCodec(codec);
  }

  /// 搜索音源
  Future<List<SourceInfo>> search(String query) {
    return _notifier.search(query);
  }

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackModel track}) {
    return _notifier.fetchFromTrack(track: track);
  }

  /// 获取所有可用音源插件
  List<String> getAvailableSources() {
    return _state.availablePlugins;
  }
}
