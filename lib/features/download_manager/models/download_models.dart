import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum DownloadStatus {
  queued,
  downloading,
  paused,
  completed,
  failed,
  canceled;

  bool get isCompleted => this == DownloadStatus.completed;
  bool get isDownloading => this == DownloadStatus.downloading;
}

class DownloadRequest {
  final String url;
  final String path;
  bool forceDownload;
  CancelToken cancelToken = CancelToken();

  DownloadRequest(this.url, this.path, {this.forceDownload = false});
}

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
}

typedef DownloadStatusEvent = ({DownloadStatus status, DownloadRequest request});
