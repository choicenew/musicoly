import 'package:flutter/foundation.dart';
import 'base_service.dart';
import '../interfaces/player/playback_interface.dart';
import '../interfaces/player/player_interface.dart';

/// 播放服务接口 - 提供跨平台的播放控制功能
abstract class PlaybackService extends BaseService {
  /// 播放曲目
  Future<void> playTrack(String trackId);

  /// 暂停播放
  Future<void> pausePlayback();

  /// 恢复播放
  Future<void> resumePlayback();

  /// 停止播放
  Future<void> stopPlayback();

  /// 跳转到指定位置
  Future<void> seekTo(Duration position);

  /// 设置音量
  Future<void> setVolume(double volume);

  /// 切换到下一首
  Future<void> skipToNext();

  /// 切换到上一首
  Future<void> skipToPrevious();

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode);

  /// 设置随机播放
  Future<void> setShuffleMode(bool enabled);

  /// 获取当前播放位置流
  Stream<Duration> get positionStream;

  /// 获取当前缓冲位置流
  Stream<Duration> get bufferedPositionStream;

  /// 获取当前曲目总时长流
  Stream<Duration> get durationStream;

  /// 获取当前播放状态流
  Stream<PlaybackState> get playbackStateStream;

  /// 获取当前曲目ID流
  Stream<String?> get currentTrackStream;

  /// 获取当前音量流
  Stream<double> get volumeStream;

  /// 获取当前重复模式流
  Stream<RepeatMode> get repeatModeStream;

  /// 获取当前随机播放模式流
  Stream<bool> get shuffleModeStream;
}
