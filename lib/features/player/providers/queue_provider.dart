import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/queue_service_impl.dart';

import 'playback_provider.dart';

part 'queue_provider.freezed.dart';
part 'queue_provider.g.dart';

/// 队列状态 - 存储播放队列的当前状态
@freezed
abstract class QueueState with _$QueueState {
  const factory QueueState({
    @Default([]) List<String> queue,
    @Default(-1) int currentIndex,
    @Default([]) List<String> history,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _QueueState;

  const QueueState._();

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
}

/// 队列状态提供者 - 管理播放队列状态
@Riverpod(keepAlive: true)
class QueueStateNotifier extends _$QueueStateNotifier {
  /// 队列服务
  late final QueueServiceImpl _queueService;

  @override
  QueueState build() {
    _queueService = QueueServiceImpl();
    _initialize();

    // 监听播放状态以同步当前索引
    ref.listen(playbackStateProvider, (previous, next) {
      if (next.currentTrackId != null) {
        final index = state.queue.indexOf(next.currentTrackId!);
        if (index != -1 && index != state.currentIndex) {
          state = state.copyWith(currentIndex: index);
        }
      }
    });

    return const QueueState();
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
