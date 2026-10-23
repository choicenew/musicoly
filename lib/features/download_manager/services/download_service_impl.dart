import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/features/download_manager/models/download_models.dart';
import 'package:pyro_music/features/download_manager/services/chunked_download.dart';
import 'package:pyro_music/services/logger/logger.dart';

/// 下载服务实现类
class DownloadServiceImpl implements DownloadManagerService {
  final Map<String, DownloadTask> _cache = <String, DownloadTask>{};
  final Queue<DownloadRequest> _queue = Queue();
  var dio = Dio();
  static const partialExtension = ".partial";
  static const tempExtension = ".temp";

  final _statusStreamController =
      StreamController<DownloadStatusEvent>.broadcast();
  @override
  Stream<DownloadStatusEvent> get statusStream =>
      _statusStreamController.stream;

  int maxConcurrentTasks = 2;
  int runningTasks = 0;

  static final DownloadServiceImpl _instance = DownloadServiceImpl._internal();

  DownloadServiceImpl._internal();

  factory DownloadServiceImpl({int? maxConcurrentTasks}) {
    if (maxConcurrentTasks != null) {
      _instance.maxConcurrentTasks = maxConcurrentTasks;
    }
    return _instance;
  }

  void Function(int, int) createCallback(url, int partialFileLength) =>
      (int received, int total) {
        _instance.getDownload(url)?.progress.value =
            (received + partialFileLength) / (total + partialFileLength);
      };

  Future<void> download(
    String url,
    String savePath,
    CancelToken cancelToken, {
    forceDownload = false,
  }) async {
    late String partialFilePath;
    late File partialFile;
    try {
      final task = getDownload(url);

      if (task == null || task.status.value == DownloadStatus.canceled) {
        return;
      }
      setStatus(task, DownloadStatus.downloading);

      final file = File(savePath.toString());

      await Directory(path.dirname(savePath)).create(recursive: true);

      final tmpDirPath = await Directory(
        path.join(
          (await getTemporaryDirectory()).path,
          "pyro_music-downloads",
        ),
      ).create(recursive: true);

      partialFilePath = path.join(
        tmpDirPath.path,
        path.basename(savePath) + partialExtension,
      );
      partialFile = File(partialFilePath);

      final fileExist = await file.exists();
      final partialFileExist = await partialFile.exists();

      if (fileExist) {
        setStatus(task, DownloadStatus.completed);
      } else if (partialFileExist) {
        final partialFileLength = await partialFile.length();

        final response = await dio.download(
          url,
          partialFilePath + tempExtension,
          onReceiveProgress: createCallback(url, partialFileLength),
          options: Options(
            headers: {
              HttpHeaders.rangeHeader: 'bytes=$partialFileLength-',
              HttpHeaders.connectionHeader: "close",
            },
          ),
          cancelToken: cancelToken,
          deleteOnError: true,
        );

        if (response.statusCode == HttpStatus.partialContent) {
          final ioSink = partialFile.openWrite(mode: FileMode.writeOnlyAppend);
          final partialChunkFile = File(partialFilePath + tempExtension);
          await ioSink.addStream(partialChunkFile.openRead());
          await partialChunkFile.delete();
          await ioSink.close();

          await partialFile.copy(savePath);
          await partialFile.delete();

          setStatus(task, DownloadStatus.completed);
        }
      } else {
        final response = await dio.chunkedDownload(
          url,
          savePath: partialFilePath,
          onReceiveProgress: createCallback(url, 0),
          cancelToken: cancelToken,
          deleteOnError: true,
        );

        if (response.statusCode == HttpStatus.ok) {
          await partialFile.copy(savePath);
          await partialFile.delete();
          setStatus(task, DownloadStatus.completed);
        }
      }
    } catch (e, stackTrace) {
      AppLogger.error('Download failed', e, stackTrace);

      var task = getDownload(url)!;
      if (task.status.value != DownloadStatus.canceled &&
          task.status.value != DownloadStatus.paused) {
        setStatus(task, DownloadStatus.failed);
        runningTasks--;

        if (_queue.isNotEmpty) {
          _startExecution();
        }
        rethrow;
      } else if (task.status.value == DownloadStatus.paused) {
        final ioSink = partialFile.openWrite(mode: FileMode.writeOnlyAppend);
        final f = File(partialFilePath + tempExtension);
        if (await f.exists()) {
          await ioSink.addStream(f.openRead());
        }
        await ioSink.close();
      }
    }

    runningTasks--;

    if (_queue.isNotEmpty) {
      _startExecution();
    }
  }

  void disposeNotifiers(DownloadTask task) {
    // 不再需要手动释放，由Flutter框架管理
  }

  void setStatus(DownloadTask? task, DownloadStatus status) {
    if (task != null) {
      task.status.value = status;

      if (status.isCompleted) {
        disposeNotifiers(task);
      }

      _statusStreamController.add((status: status, request: task.request));
    }
  }

  @override
  Future<DownloadTask?> addDownload(String url, String savedPath,
      {bool forceDownload = false}) async {
    if (url.isEmpty) throw Exception("Invalid Url. Url is empty: $url");
    final request = DownloadRequest(url, savedPath);
    request.forceDownload = forceDownload;
    return _addDownloadRequest(request);
  }

  Future<DownloadTask> _addDownloadRequest(
    DownloadRequest downloadRequest,
  ) async {
    if (_cache.containsKey(downloadRequest.url)) {
      var task = _cache[downloadRequest.url]!;
      if (task.status.value == DownloadStatus.paused) {
        resumeDownload(downloadRequest.url);
      }
      return task;
    }

    final task = DownloadTask(
      downloadRequest,
      initialStatus: DownloadStatus.queued,
      initialProgress: 0.0,
    );

    _cache[downloadRequest.url] = task;
    _queue.add(downloadRequest);

    if (runningTasks < maxConcurrentTasks) {
      _startExecution();
    }

    return task;
  }

  void _startExecution() {
    if (_queue.isEmpty) return;

    runningTasks++;
    var request = _queue.removeFirst();

    download(
      request.url,
      request.path,
      request.cancelToken,
      forceDownload: request.forceDownload,
    );
  }

  @override
  void cancelDownload(String url) {
    var task = getDownload(url);
    if (task != null) {
      task.request.cancelToken.cancel();
      setStatus(task, DownloadStatus.canceled);
    }
  }

  @override
  void pauseDownload(String url) {
    var task = getDownload(url);
    if (task != null) {
      task.request.cancelToken.cancel();
      task.request.cancelToken = CancelToken();
      setStatus(task, DownloadStatus.paused);
    }
  }

  @override
  void resumeDownload(String url) {
    var task = getDownload(url);
    if (task != null) {
      setStatus(task, DownloadStatus.queued);
      _queue.add(task.request);
      if (runningTasks < maxConcurrentTasks) {
        _startExecution();
      }
    }
  }

  @override
  void removeDownload(String url) {
    cancelDownload(url);
    _cache.remove(url);
  }

  @override
  DownloadTask? getDownload(String url) {
    return _cache[url];
  }

  @override
  List<DownloadTask> getAllDownloads() {
    return _cache.values.toList();
  }

  @override
  void cancelAllDownloads() {
    for (var task in getAllDownloads()) {
      cancelDownload(task.request.url);
    }
  }
}
