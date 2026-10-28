import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/features/download_manager/models/download_models.dart';
import 'package:pyro_music/features/download_manager/services/download_service_impl.dart';

part 'download_provider.freezed.dart';
part 'download_provider.g.dart';

/// Download state data class
@freezed
abstract class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default([]) List<DownloadTask> tasks,
    DownloadStatusEvent? lastEvent,
  }) = _DownloadState;
}

/// 下载管理器提供者实现类
@Riverpod(keepAlive: true)
class DownloadNotifier extends _$DownloadNotifier {
  late final DownloadServiceImpl _downloadService;
  StreamSubscription? _statusSubscription;

  @override
  DownloadState build() {
    _downloadService = DownloadServiceImpl();
    _initialize();
    
    ref.onDispose(() {
      _statusSubscription?.cancel();
    });
    
    return const DownloadState();
  }

  void _initialize() {
    state = state.copyWith(tasks: _downloadService.getAllTasks());

    _statusSubscription = _downloadService.statusStream.listen((event) {
      state = state.copyWith(
        tasks: _downloadService.getAllTasks(),
        lastEvent: event,
      );
    });
  }

  Stream<DownloadStatusEvent> get statusStream => _downloadService.statusStream;

  Future<void> addDownload(String url, String savePath,
      {bool forceDownload = false}) async {
    final request = DownloadRequest(url, savePath, forceDownload: forceDownload);
    await _downloadService.enqueue(request);
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }

  void cancelAllDownloads() {
    for (final task in _downloadService.getAllTasks()) {
      _downloadService.cancel(task.request.url);
    }
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }

  void cancelDownload(String url) {
    _downloadService.cancel(url);
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }

  List<DownloadTask> getAllDownloads() {
    return state.tasks;
  }

  DownloadTask? getDownload(String url) {
    return _downloadService.getTask(url);
  }

  void pauseDownload(String url) {
    _downloadService.pause(url);
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }

  void removeDownload(String url) {
    _downloadService.cancel(url);
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }

  void resumeDownload(String url) {
    _downloadService.resume(url);
    state = state.copyWith(tasks: _downloadService.getAllTasks());
  }
}
