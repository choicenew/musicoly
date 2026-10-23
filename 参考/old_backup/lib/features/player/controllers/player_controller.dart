import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base/interfaces/player/player_interface.dart';
import '../providers/player_state_provider.dart';
import '../providers/playback_provider.dart';
import '../providers/queue_provider.dart';

/// 播放器控制器 - 提供统一的播放控制接口
///
/// 整合播放器状态提供者和播放控制状态提供者，提供统一的播放控制接口
class PlayerController {
  /// 引用阅读器
  final Ref _ref;

  /// 构造函数
  PlayerController(this._ref);

  /// 获取播放器状态提供者
  PlayerStateNotifier get _playerStateNotifier =>
      _ref.read(playerStateProvider.notifier);

  /// 获取播放控制状态提供者
  PlaybackStateNotifier get _playbackStateNotifier =>
      _ref.read(playbackStateProvider.notifier);

  /// 获取队列状态提供者
  QueueStateNotifier get _queueStateNotifier =>
      _ref.read(queueStateProvider.notifier);

  /// 获取播放器状态
  PlayerState get playerState => _ref.read(playerStateProvider);

  /// 获取播放控制状态
  PlaybackStateData get playbackState => _ref.read(playbackStateProvider);

  /// 获取队列状态
  QueueState get queueState => _ref.read(queueStateProvider);

  /// 播放曲目
  Future<void> play(
      {required String trackId, String? sourceId, String? sourceName}) async {
    await _playerStateNotifier.play(
      trackId: trackId,
      sourceId: sourceId,
      sourceName: sourceName,
    );
  }

  /// 暂停播放
  Future<void> pause() async {
    await _playerStateNotifier.pause();
  }

  /// 恢复播放
  Future<void> resume() async {
    await _playerStateNotifier.resume();
  }

  /// 停止播放
  Future<void> stop() async {
    await _playerStateNotifier.stop();
  }

  /// 跳转到指定位置
  Future<void> seekTo(Duration position) async {
    await _playbackStateNotifier.seekTo(position);
  }

  /// 设置音量
  Future<void> setVolume(double volume) async {
    await _playbackStateNotifier.setVolume(volume);
  }

  /// 下一曲
  Future<void> next() async {
    await _playerStateNotifier.next();
  }

  /// 上一曲
  Future<void> previous() async {
    await _playerStateNotifier.previous();
  }

  /// 设置重复模式
  Future<void> setRepeatMode(RepeatMode mode) async {
    await _playerStateNotifier.setRepeatMode(mode);
  }

  /// 设置随机播放模式
  Future<void> setShuffleMode(bool enabled) async {
    await _playerStateNotifier.setShuffleMode(enabled);
  }

  /// 添加曲目到队列
  Future<void> addToQueue(String trackId) async {
    await _queueStateNotifier.addTrack(trackId);
  }

  /// 添加多个曲目到队列
  Future<void> addTracksToQueue(List<String> trackIds) async {
    await _queueStateNotifier.addTracks(trackIds);
  }

  /// 从队列中移除曲目
  Future<void> removeFromQueue(String trackId) async {
    await _queueStateNotifier.removeTrack(trackId);
  }

  /// 从队列中移除指定索引的曲目
  Future<void> removeFromQueueAt(int index) async {
    await _queueStateNotifier.removeTrackAt(index);
  }

  /// 清空队列
  Future<void> clearQueue() async {
    await _queueStateNotifier.clearQueue();
  }

  /// 移动队列中的曲目
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    await _queueStateNotifier.moveTrack(oldIndex, newIndex);
  }

  /// 跳转到队列中指定索引的曲目
  Future<void> skipToQueueItem(int index) async {
    await _queueStateNotifier.skipToIndex(index);

    // 获取曲目ID并播放
    final trackId = queueState.queue[index];
    await play(trackId: trackId);
  }

  /// 替换整个队列并开始播放
  Future<void> playQueue(List<String> trackIds, {int startIndex = 0}) async {
    // 替换队列
    await _queueStateNotifier.replaceQueue(trackIds, startIndex: startIndex);

    // 播放指定索引的曲目
    if (trackIds.isNotEmpty && startIndex < trackIds.length) {
      await play(trackId: trackIds[startIndex]);
    }
  }

  /// 清空播放历史
  Future<void> clearHistory() async {
    await _queueStateNotifier.clearHistory();
  }

  /// 清除错误状态
  void clearError() {
    _playerStateNotifier.clearError();
    _queueStateNotifier.clearError();
  }
}

/// 播放器控制器提供者
final playerControllerProvider = Provider<PlayerController>((ref) {
  return PlayerController(ref);
});
