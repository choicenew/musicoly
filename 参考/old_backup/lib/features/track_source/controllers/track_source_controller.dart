import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/features/track_source/providers/track_source_provider.dart';

/// 音轨源控制器
/// 负责处理音轨源的用户交互逻辑
class TrackSourceController {
  final TrackSourceProvider _provider;

  TrackSourceController({TrackSourceProvider? provider})
      : _provider = provider ?? TrackSourceProvider();

  /// 获取当前音频源
  AudioSource get currentSource => _provider.currentSource;

  /// 获取当前音频质量
  SourceQualities get quality => _provider.quality;

  /// 获取当前音频编解码器
  SourceCodecs get codec => _provider.codec;

  /// 设置音频源
  void setSource(AudioSource source) {
    _provider.setSource(source);
  }

  /// 设置音频质量
  void setQuality(SourceQualities quality) {
    _provider.setQuality(quality);
  }

  /// 设置音频编解码器
  void setCodec(SourceCodecs codec) {
    _provider.setCodec(codec);
  }

  /// 搜索音源
  Future<List<SourceInfo>> search(String query) {
    return _provider.search(query);
  }

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track}) {
    return _provider.fetchFromTrack(track: track);
  }

  /// 从备选音源获取轨道
  Future<SourcedTrack> fetchFromTrackAltSource(
      {required TrackInterface track}) {
    return _provider.fetchFromTrackAltSource(track: track);
  }

  /// 切换到下一个可用音源
  void switchToNextSource() {
    const sources = AudioSource.values;
    final currentIndex = sources.indexOf(currentSource);
    final nextIndex = (currentIndex + 1) % sources.length;
    setSource(sources[nextIndex]);
  }

  /// 获取所有可用音源
  List<AudioSource> getAvailableSources() {
    return AudioSource.values;
  }
}
