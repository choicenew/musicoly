import 'package:flutter/foundation.dart';

import '../../../core/base/services/base_service.dart';
import '../../../core/base/interfaces/player/queue_interface.dart';
import '../../../core/base/interfaces/media/track_interface.dart';
import '../../../core/services/service_registry.dart';
import '../../../core/platform/platform_registry.dart';

/// 队列服务实现 - 管理播放队列
///
/// 提供统一的队列管理接口，整合不同平台的队列功能
class QueueServiceImpl extends BaseService implements QueueInterface {
  /// 服务注册表实例
  final ServiceRegistry _serviceRegistry = ServiceRegistry();

  /// 平台注册表实例
  final PlatformRegistry _platformRegistry = PlatformRegistry();

  /// 当前活跃的队列服务
  QueueInterface? _activeQueueService;

  /// 当前队列
  List<String> _queue = [];

  /// 当前索引
  int _currentIndex = -1;

  /// 播放历史
  List<String> _history = [];

  /// 构造函数
  QueueServiceImpl() {
    _initializeActiveService();
  }

  /// 初始化活跃服务
  Future<void> _initializeActiveService() async {
    final platformId = _platformRegistry.activePlatformId;
    if (platformId.isNotEmpty) {
      final service = _serviceRegistry.getService<BaseService>(platformId);
      if (service is QueueInterface) {
        _activeQueueService = service;
        debugPrint('已设置活跃队列服务: $platformId');
        // 同步队列状态
        _syncQueueState();
      }
    }
  }

  /// 同步队列状态
  Future<void> _syncQueueState() async {
    if (_activeQueueService != null) {
      _queue = await _activeQueueService!.getQueue();
      _currentIndex = await _activeQueueService!.getCurrentIndex();
      _history = await _activeQueueService!.getHistory();
    }
  }

  @override
  String get serviceId => 'queue_service';

  @override
  String get serviceName => '队列服务';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null; // 不依赖特定平台

  @override
  Future<void> initialize() async {
    await _initializeActiveService();
  }

  @override
  Future<void> addTrack(String trackId) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.addTrack(trackId);
    }

    // 更新本地队列
    _queue.add(trackId);
    debugPrint('已添加曲目到队列: $trackId');
  }

  @override
  Future<void> addTracks(List<String> trackIds) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.addTracks(trackIds);
    }

    // 更新本地队列
    _queue.addAll(trackIds);
    debugPrint('已添加${trackIds.length}首曲目到队列');
  }

  @override
  Future<void> removeTrack(String trackId) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.removeTrack(trackId);
    }

    // 更新本地队列
    _queue.remove(trackId);
    debugPrint('已从队列中移除曲目: $trackId');
  }

  @override
  Future<void> removeTrackAt(int index) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.removeTrackAt(index);
    }

    // 更新本地队列
    if (index >= 0 && index < _queue.length) {
      _queue.removeAt(index);
      debugPrint('已从队列中移除索引为 $index 的曲目');

      // 更新当前索引
      if (index < _currentIndex) {
        _currentIndex--;
      } else if (index == _currentIndex && _currentIndex >= _queue.length) {
        _currentIndex = _queue.isEmpty ? -1 : _queue.length - 1;
      }
    }
  }

  @override
  Future<void> clearQueue() async {
    if (_activeQueueService != null) {
      await _activeQueueService!.clearQueue();
    }

    // 更新本地队列
    _queue.clear();
    _currentIndex = -1;
    debugPrint('已清空队列');
  }

  @override
  Future<List<String>> getQueue() async {
    if (_activeQueueService != null) {
      _queue = await _activeQueueService!.getQueue();
    }
    return _queue;
  }

  @override
  Future<int> getCurrentIndex() async {
    if (_activeQueueService != null) {
      _currentIndex = await _activeQueueService!.getCurrentIndex();
    }
    return _currentIndex;
  }

  @override
  Future<void> moveTrack(int oldIndex, int newIndex) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.moveTrack(oldIndex, newIndex);
    }

    // 更新本地队列
    if (oldIndex >= 0 &&
        oldIndex < _queue.length &&
        newIndex >= 0 &&
        newIndex < _queue.length) {
      final trackId = _queue.removeAt(oldIndex);
      _queue.insert(newIndex, trackId);
      debugPrint('已移动队列中的曲目: $oldIndex -> $newIndex');

      // 更新当前索引
      if (_currentIndex == oldIndex) {
        _currentIndex = newIndex;
      } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
        _currentIndex--;
      } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
        _currentIndex++;
      }
    }
  }

  @override
  Future<void> skipToIndex(int index) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.skipToIndex(index);
    }

    // 更新本地队列索引
    if (index >= 0 && index < _queue.length) {
      _currentIndex = index;
      debugPrint('已跳转到队列索引: $index');

      // 添加到历史记录
      if (_currentIndex >= 0 && _currentIndex < _queue.length) {
        _history.add(_queue[_currentIndex]);
      }
    }
  }

  @override
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0}) async {
    if (_activeQueueService != null) {
      await _activeQueueService!.replaceQueue(trackIds, startIndex: startIndex);
    }

    // 更新本地队列
    _queue = List.from(trackIds);
    _currentIndex = startIndex < _queue.length ? startIndex : -1;
    debugPrint('已替换队列，共${trackIds.length}首曲目，起始索引: $startIndex');
  }

  @override
  Future<List<String>> getHistory() async {
    if (_activeQueueService != null) {
      _history = await _activeQueueService!.getHistory();
    }
    return _history;
  }

  @override
  Future<void> clearHistory() async {
    if (_activeQueueService != null) {
      await _activeQueueService!.clearHistory();
    }

    // 更新本地历史记录
    _history.clear();
    debugPrint('已清空播放历史');
  }

  @override
  Future<bool> isAvailable() async {
    return true;
  }

  @override
  Map<String, dynamic> getConfig() {
    return {
      'maxQueueSize': 1000,
      'maxHistorySize': 100,
      'autoSync': true,
    };
  }

  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {
    debugPrint('更新队列服务配置: $config');
  }

  @override
  List<Type> getDependencies() {
    return [];
  }

  @override
  ServiceStatus getStatus() {
    return ServiceStatus.available;
  }

  @override
  Future<void> dispose() async {
    debugPrint('释放队列服务资源');
  }
}
