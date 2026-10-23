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
    // Initial tasks load
    state = state.copyWith(tasks: _downloadService.getAllDownloads());

    // Listen to status stream
    _statusSubscription = _downloadService.statusStream.listen((event) {
      // Update state when event occurs
      // Since we want to update the list of tasks as well, we might need to re-fetch or update locally
      // For now, let's re-fetch the list to be safe, or just update the event
      state = state.copyWith(
        tasks: _downloadService.getAllDownloads(),
        lastEvent: event,
      );
    });
  }

  Stream<DownloadStatusEvent> get statusStream => _downloadService.statusStream;

  Future<DownloadTask?> addDownload(String url, String savePath,
      {bool forceDownload = false}) async {
    final task = await _downloadService.addDownload(url, savePath,
        forceDownload: forceDownload);
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
    return task;
  }

  void cancelAllDownloads() {
    _downloadService.cancelAllDownloads();
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
  }

  void cancelDownload(String url) {
    _downloadService.cancelDownload(url);
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
  }

  List<DownloadTask> getAllDownloads() {
    return state.tasks;
  }

  DownloadTask? getDownload(String url) {
    return _downloadService.getDownload(url);
  }

  void pauseDownload(String url) {
    _downloadService.pauseDownload(url);
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
  }

  void removeDownload(String url) {
    _downloadService.removeDownload(url);
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
  }

  void resumeDownload(String url) {
    _downloadService.resumeDownload(url);
    state = state.copyWith(tasks: _downloadService.getAllDownloads());
  }
}
