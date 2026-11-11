import 'package:flutter/foundation.dart';

/// Two-Stage Snappy Loading Protocol Implementation
/// Stage 1: 0ms Instant Cache Restore (No Fullscreen Spinner)
/// Stage 2: Background Async Refresh & Smooth Fade Transition
class TwoStageSnappyLoader<T> {
  final Future<T?> Function() fetchLocalCache;
  final Future<T> Function() fetchRemoteData;
  final Function(T cacheData) onStage1CacheLoaded;
  final Function(T remoteData) onStage2RemoteLoaded;
  final Function(Object error)? onError;

  TwoStageSnappyLoader({
    required this.fetchLocalCache,
    required this.fetchRemoteData,
    required this.onStage1CacheLoaded,
    required this.onStage2RemoteLoaded,
    this.onError,
  });

  /// 异步拉起双阶极速加载工作流
  Future<void> execute() async {
    // Stage 1: 尝试立刻恢复本地缓存数据 (0ms 闪现)
    try {
      final cached = await fetchLocalCache();
      if (cached != null) {
        onStage1CacheLoaded(cached);
      }
    } catch (e) {
      debugPrint('Stage 1 Cache Restore Warning: $e');
    }

    // Stage 2: 后台静默发起网络拉取并平滑更新
    try {
      final fresh = await fetchRemoteData();
      onStage2RemoteLoaded(fresh);
    } catch (e) {
      debugPrint('Stage 2 Remote Refresh Error: $e');
      onError?.call(e);
    }
  }
}
