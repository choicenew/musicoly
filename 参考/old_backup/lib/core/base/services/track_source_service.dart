import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';

/// 音轨源服务接口
abstract class TrackSourceService {
  /// 当前选择的音频源
  AudioSource get currentSource;

  /// 音频质量
  SourceQualities get quality;

  /// 音频编解码器
  SourceCodecs get codec;

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track});

  /// 从备选音源获取轨道
  Future<SourcedTrack> fetchFromTrackAltSource({required TrackInterface track});

  /// 搜索音源
  Future<List<SourceInfo>> search(String query);

  /// 设置当前音频源
  void setSource(AudioSource source);

  /// 设置音频质量
  void setQuality(SourceQualities quality);

  /// 设置音频编解码器
  void setCodec(SourceCodecs codec);
}
