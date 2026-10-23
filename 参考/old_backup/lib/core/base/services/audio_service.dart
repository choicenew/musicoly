import 'package:pyro_music/core/base/services/base_service.dart';

import '../interfaces/audio/audio_processing_interface.dart';

abstract class AudioService extends BaseService
    implements AudioProcessingInterface {
  /// 获取当前音频质量配置
  String get currentQuality;
  
  /// 音量标准化状态流
  Stream<bool> get volumeNormalizationStream;
  
  /// 静音跳过状态流  
  Stream<bool> get skipSilenceStream;
  
  /// 交叉淡入淡出时长流
  Stream<Duration> get crossfadeDurationStream;
  
  /// 新增交叉淡入淡出效果控制方法
  /// [duration] 淡入淡出时长（0表示关闭）
  Future<void> applyCrossfadeEffect(Duration duration);
}