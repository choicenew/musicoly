import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/queue_provider.dart';

/// 队列控制器 - 提供队列管理功能
///
/// 与队列状态提供者交互，提供队列管理功能
class QueueController {
  /// 引用阅读器
  final Ref _ref;

  /// 构造函数
  QueueController(this._ref);

  /// 获取队列状态提供者
  QueueStateNotifier get _queueStateNotifier =>
      _ref.read(queueStateProvider.notifier);

  /// 获取队列状态
  QueueState get queueState => _ref.read(queueStateProvider);

  /// 获取当前队列
  List<String> get queue => queueState.queue;

  /// 获取当前索引
  int get currentIndex => queueState.currentIndex;

  /// 获取播放历史
  List<String> get history => queueState.history;

  /// 获取当前曲目ID
  String? get currentTrackId => queueState.currentTrackId;

  /// 获取下一曲目ID
  String? get nextTrackId => queueState.nextTrackId;

  /// 获取上一曲目ID
  String? get previousTrackId => queueState.previousTrackId;

  /// 添加曲目到队列
  Future<void> addTrack(String trackId) async {
    await _queueStateNotifier.addTrack(trackId);
  }

  /// 添加多个曲目到队列
  Future<void> addTracks(List<String> trackIds) async {
    await _queueStateNotifier.addTracks(trackIds);
  }

  /// 从队列中移除曲目
  Future<void> removeTrack(String trackId) async {
    await _queueStateNotifier.removeTrack(trackId);
  }

  /// 从队列中移除指定索引的曲目
  Future<void> removeTrackAt(int index) async {
    await _queueStateNotifier.removeTrackAt(index);
  }

  /// 清空队列
  Future<void> clearQueue() async {
    await _queueStateNotifier.clearQueue();
  }

  /// 移动队列中的曲目
  Future<void> moveTrack(int oldIndex, int newIndex) async {
    await _queueStateNotifier.moveTrack(oldIndex, newIndex);
  }

  /// 跳转到指定索引的曲目
  Future<void> skipToIndex(int index) async {
    await _queueStateNotifier.skipToIndex(index);
  }

  /// 替换整个队列
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0}) async {
    await _queueStateNotifier.replaceQueue(trackIds, startIndex: startIndex);
  }

  /// 清空播放历史
  Future<void> clearHistory() async {
    await _queueStateNotifier.clearHistory();
  }

  /// 获取队列长度
  int get queueLength => queue.length;

  /// 获取历史记录长度
  int get historyLength => history.length;

  /// 检查队列是否为空
  bool get isQueueEmpty => queue.isEmpty;

  /// 检查是否有下一曲
  bool get hasNext => currentIndex < queue.length - 1;

  /// 检查是否有上一曲
  bool get hasPrevious => currentIndex > 0;

  /// 清除错误状态
  void clearError() {
    _queueStateNotifier.clearError();
  }
}

/// 队列控制器提供者
final queueControllerProvider = Provider<QueueController>((ref) {
  return QueueController(ref);
});
