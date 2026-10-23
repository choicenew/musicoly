import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/queue_service_impl.dart';

/// 队列状态 - 存储播放队列的当前状态
class QueueState {
  /// 当前队列中的曲目ID列表
  final List<String> queue;

  /// 当前播放索引
  final int currentIndex;

  /// 播放历史
  final List<String> history;

  /// 是否正在加载
  final bool isLoading;

  /// 是否发生错误
  final bool hasError;

  /// 错误信息
  final String? errorMessage;

  /// 构造函数
  const QueueState({
    this.queue = const [],
    this.currentIndex = -1,
    this.history = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  /// 复制并更新状态
  QueueState copyWith({
    List<String>? queue,
    int? currentIndex,
    List<String>? history,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return QueueState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// 获取当前曲目ID
  String? get currentTrackId {
    if (currentIndex >= 0 && currentIndex < queue.length) {
      return queue[currentIndex];
    }
    return null;
  }

  /// 获取下一曲目ID
  String? get nextTrackId {
    if (currentIndex >= 0 && currentIndex < queue.length - 1) {
      return queue[currentIndex + 1];
    }
    return null;
  }

  /// 获取上一曲目ID
  String? get previousTrackId {
    if (currentIndex > 0 && currentIndex < queue.length) {
      return queue[currentIndex - 1];
    }
    return null;
  }

  @override
  String toString() {
    return 'QueueState(queue: ${queue.length} tracks, currentIndex: $currentIndex, '
        'history: ${history.length} tracks, isLoading: $isLoading, '
        'hasError: $hasError, errorMessage: $errorMessage)';
  }
}

/// 队列状态提供者 - 管理播放队列状态
class QueueStateNotifier extends StateNotifier<QueueState> {
  /// 队列服务
  final QueueServiceImpl _queueService;

  /// 构造函数
  QueueStateNotifier(this._queueService) : super(const QueueState()) {
    _initialize();
  }

  /// 初始化
  Future<void> _initialize() async {
    try {
      // 更新状态为加载中
      state = state.copyWith(isLoading: true);

      // 初始化队列服务
      await _queueService.initialize();

      // 获取当前队列
      final queue = await _queueService.getQueue();
      final currentIndex = await _queueService.getCurrentIndex();
      final history = await _queueService.getHistory();

      // 更新状态
      state = state.copyWith(
        queue: queue,
        currentIndex: currentIndex,
        history: history,
        isLoading: false,
      );
    } catch (e) {
      // 更新错误状态
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 添加曲目到队列
  Future<void> addTrack(String trackId) async {
    try {
      await _queueService.addTrack(trackId);

      // 更新队列
      final queue = await _queueService.getQueue();
      state = state.copyWith(queue: queue);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 添加多个曲目到队列
  Future<void> addTracks(List<String> trackIds) async {
    try {
      await _queueService.addTracks(trackIds);

      // 更新队列
      final queue = await _queueService.getQueue();
      state = state.copyWith(queue: queue);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 从队列中移除曲目
  Future<void> removeTrack(String trackId) async {
    try {
      await _queueService.removeTrack(trackId);

      // 更新队列
      final queue = await _queueService.getQueue();
      final currentIndex = await _queueService.getCurrentIndex();
      state = state.copyWith(
        queue: queue,
        currentIndex: currentIndex,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 从队列中移除指定索引的曲目
  Future<void> removeTrackAt(int index) async {
    try {
      await _queueService.removeTrackAt(index);

      // 更新队列
      final queue = await _queueService.getQueue();
      final currentIndex = await _queueService.getCurrentIndex();
      state = state.copyWith(
        queue: queue,
        currentIndex: currentIndex,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 清空队列
  Future<void> clearQueue() async {
    try {
      await _queueService.clearQueue();

      // 更新状态
      state = state.copyWith(
        queue: [],
        currentIndex: -1,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 移动队列中的曲目
  Future<void> moveTrack(int oldIndex, int newIndex) async {
    try {
      await _queueService.moveTrack(oldIndex, newIndex);

      // 更新队列
      final queue = await _queueService.getQueue();
      final currentIndex = await _queueService.getCurrentIndex();
      state = state.copyWith(
        queue: queue,
        currentIndex: currentIndex,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 跳转到指定索引的曲目
  Future<void> skipToIndex(int index) async {
    try {
      state = state.copyWith(isLoading: true);
      await _queueService.skipToIndex(index);

      // 更新当前索引
      state = state.copyWith(
        currentIndex: index,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 替换整个队列
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0}) async {
    try {
      state = state.copyWith(isLoading: true);
      await _queueService.replaceQueue(trackIds, startIndex: startIndex);

      // 更新队列
      state = state.copyWith(
        queue: trackIds,
        currentIndex: startIndex,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 清空播放历史
  Future<void> clearHistory() async {
    try {
      await _queueService.clearHistory();

      // 更新历史记录
      state = state.copyWith(history: []);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 清除错误状态
  void clearError() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
    );
  }
}

/// 队列状态提供者
final queueStateProvider =
    StateNotifierProvider<QueueStateNotifier, QueueState>((ref) {
  final queueService = QueueServiceImpl();
  return QueueStateNotifier(queueService);
});
