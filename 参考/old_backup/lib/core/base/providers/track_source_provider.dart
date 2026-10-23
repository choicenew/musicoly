import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';

/// 音轨源提供者接口
abstract class TrackSourceProvider {
  /// 当前选择的音频源
  AudioSource get currentSource;

  /// 音频质量
  SourceQualities get quality;

  /// 音频编解码器
  SourceCodecs get codec;

  /// 设置当前音频源
  void setSource(AudioSource source);

  /// 设置音频质量
  void setQuality(SourceQualities quality);

  /// 设置音频编解码器
  void setCodec(SourceCodecs codec);
}
