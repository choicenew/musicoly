import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 下载状态枚举
enum DownloadStatus {
  queued,
  downloading,
  completed,
  failed,
  paused,
  canceled;

  bool get isCompleted {
    switch (this) {
      case DownloadStatus.queued:
        return false;
      case DownloadStatus.downloading:
        return false;
      case DownloadStatus.paused:
        return false;
      case DownloadStatus.completed:
        return true;
      case DownloadStatus.failed:
        return true;
      case DownloadStatus.canceled:
        return true;
    }
  }
}

/// 下载请求类
class DownloadRequest {
  final String url;
  final String path;
  var cancelToken = CancelToken();
  var forceDownload = false;

  DownloadRequest(
    this.url,
    this.path,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadRequest &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          path == other.path;

  @override
  int get hashCode => url.hashCode ^ path.hashCode;
}

/// 下载任务类
class DownloadTask {
  final DownloadRequest request;
  final ValueNotifier<DownloadStatus> status;
  final ValueNotifier<double> progress;

  DownloadTask(
    this.request, {
    DownloadStatus initialStatus = DownloadStatus.queued,
    double initialProgress = 0.0,
  })  : status = ValueNotifier(initialStatus),
        progress = ValueNotifier(initialProgress);

  Future<DownloadStatus> whenDownloadComplete({
    Duration timeout = const Duration(hours: 2),
  }) async {
    var completer = Completer<DownloadStatus>();

    if (status.value.isCompleted) {
      completer.complete(status.value);
    }

    void listener() {
      if (status.value.isCompleted) {
        completer.complete(status.value);
        status.removeListener(listener);
      }
    }

    status.addListener(listener);

    return completer.future.timeout(timeout);
  }
}

/// 下载状态事件
typedef DownloadStatusEvent = ({
  DownloadStatus status,
  DownloadRequest request
});

/// 下载管理器接口
abstract class DownloadManagerInterface {
  /// 获取下载状态流
  Stream<DownloadStatusEvent> get statusStream;

  /// 获取下载任务
  DownloadTask? getDownload(String url);

  /// 添加下载任务
  Future<DownloadTask?> addDownload(String url, String savePath,
      {bool forceDownload = false});

  /// 取消下载任务
  void cancelDownload(String url);

  /// 暂停下载任务
  void pauseDownload(String url);

  /// 恢复下载任务
  void resumeDownload(String url);

  /// 移除下载任务
  void removeDownload(String url);

  /// 获取所有下载任务
  List<DownloadTask> getAllDownloads();

  /// 取消所有下载任务
  void cancelAllDownloads();
}
