abstract class AudioProcessingInterface {
  Future<void> setVolumeNormalization(bool enabled);
  Future<void> setSkipSilence(bool enabled);
  Future<void> setCrossfadeDuration(Duration duration);
  Future<void> setAudioQuality(String quality);
  
  // 新增状态获取方法
  bool get currentVolumeNormalization;
  bool get currentSkipSilence;
  Duration get currentCrossfadeDuration;
  String get currentAudioQuality;
}