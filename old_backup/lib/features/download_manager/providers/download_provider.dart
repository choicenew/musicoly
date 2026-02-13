import 'dart:async';

import 'package:pyro_music/core/base/interfaces/download_manager/download_manager_interface.dart';
import 'package:pyro_music/core/base/providers/download_manager_provider.dart';
import 'package:pyro_music/features/download_manager/services/download_service_impl.dart';

/// 下载管理器提供者实现类
class DownloadProvider extends DownloadManagerProvider {
  final DownloadServiceImpl _downloadService;
  StreamSubscription? _statusSubscription;

  DownloadProvider({
    DownloadServiceImpl? downloadService,
  }) : _downloadService = downloadService ?? DownloadServiceImpl() {
    _statusSubscription = _downloadService.statusStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  Stream<DownloadStatusEvent> get statusStream => _downloadService.statusStream;

  @override
  Future<DownloadTask?> addDownload(String url, String savePath,
      {bool forceDownload = false}) {
    return _downloadService.addDownload(url, savePath,
        forceDownload: forceDownload);
  }

  @override
  void cancelAllDownloads() {
    _downloadService.cancelAllDownloads();
  }

  @override
  void cancelDownload(String url) {
    _downloadService.cancelDownload(url);
  }

  @override
  List<DownloadTask> getAllDownloads() {
    return _downloadService.getAllDownloads();
  }

  @override
  DownloadTask? getDownload(String url) {
    return _downloadService.getDownload(url);
  }

  @override
  void pauseDownload(String url) {
    _downloadService.pauseDownload(url);
  }

  @override
  void removeDownload(String url) {
    _downloadService.removeDownload(url);
  }

  @override
  void resumeDownload(String url) {
    _downloadService.resumeDownload(url);
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}
