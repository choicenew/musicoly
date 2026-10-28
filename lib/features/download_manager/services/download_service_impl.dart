import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pyro_music/features/download_manager/models/download_models.dart';
import 'download_service.dart';

/// 下载服务实现类
class DownloadServiceImpl implements DownloadManagerService {
  final Map<String, DownloadTask> _cache = <String, DownloadTask>{};
  final Queue<DownloadRequest> _queue = Queue();
  var dio = Dio();

  final _statusStreamController =
      StreamController<DownloadStatusEvent>.broadcast();

  @override
  Stream<DownloadStatusEvent> get statusStream =>
      _statusStreamController.stream;

  int maxConcurrentTasks = 2;
  int runningTasks = 0;

  static final DownloadServiceImpl _instance = DownloadServiceImpl._internal();

  factory DownloadServiceImpl() {
    return _instance;
  }

  DownloadServiceImpl._internal();

  @override
  Future<void> enqueue(DownloadRequest request) async {
    final task = DownloadTask(request);
    _cache[request.url] = task;
    _queue.add(request);
    _statusStreamController.add((status: task.status.value, request: request));

    _processQueue();
  }

  void _processQueue() {
    if (runningTasks >= maxConcurrentTasks || _queue.isEmpty) {
      return;
    }

    final request = _queue.removeFirst();
    runningTasks++;
    _startDownload(request);
  }

  Future<void> _startDownload(DownloadRequest request) async {
    final task = _cache[request.url];
    if (task == null) return;

    task.status.value = DownloadStatus.downloading;
    _statusStreamController.add((status: DownloadStatus.downloading, request: request));

    try {
      final saveFile = File(request.path);
      await saveFile.parent.create(recursive: true);

      await dio.download(
        request.url,
        request.path,
        cancelToken: request.cancelToken,
        onReceiveProgress: (received, total) {
          final progress = total > 0 ? (received / total) : 0.0;
          task.progress.value = progress;
        },
      );

      task.status.value = DownloadStatus.completed;
      task.progress.value = 1.0;
      _statusStreamController.add((status: DownloadStatus.completed, request: request));
    } catch (e) {
      task.status.value = DownloadStatus.failed;
      _statusStreamController.add((status: DownloadStatus.failed, request: request));
    } finally {
      runningTasks--;
      _processQueue();
    }
  }

  @override
  Future<void> pause(String taskId) async {
    final task = _cache[taskId];
    if (task != null) {
      task.request.cancelToken.cancel();
      task.status.value = DownloadStatus.paused;
      _statusStreamController.add((status: DownloadStatus.paused, request: task.request));
    }
  }

  @override
  Future<void> resume(String taskId) async {
    final task = _cache[taskId];
    if (task != null) {
      task.request.cancelToken = CancelToken();
      task.status.value = DownloadStatus.queued;
      _queue.add(task.request);
      _statusStreamController.add((status: DownloadStatus.queued, request: task.request));
      _processQueue();
    }
  }

  @override
  Future<void> cancel(String taskId) async {
    final task = _cache[taskId];
    if (task != null) {
      task.request.cancelToken.cancel();
      task.status.value = DownloadStatus.canceled;
      _statusStreamController.add((status: DownloadStatus.canceled, request: task.request));
    }
  }

  @override
  List<DownloadTask> getAllTasks() {
    return _cache.values.toList();
  }

  @override
  DownloadTask? getTask(String taskId) {
    return _cache[taskId];
  }

  @override
  void dispose() {
    _statusStreamController.close();
  }
}
