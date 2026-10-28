import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/download_manager/models/download_models.dart';
import 'package:pyro_music/features/download_manager/providers/download_provider.dart';

final downloadControllerProvider = Provider<DownloadController>((ref) {
  return DownloadController(ref);
});

/// 下载控制器
class DownloadController {
  final Ref _ref;

  DownloadController(this._ref);

  /// 获取下载提供者
  DownloadNotifier get _notifier => _ref.read(downloadProvider.notifier);

  /// 获取下载状态流
  Stream<DownloadStatusEvent> get statusStream => _notifier.statusStream;

  /// 获取下载状态
  DownloadState get state => _ref.read(downloadProvider);

  /// 获取下载任务
  DownloadTask? getDownload(String url) => _notifier.getDownload(url);

  /// 添加下载任务
  Future<void> addDownload(String url, String savePath,
          {bool forceDownload = false}) =>
      _notifier.addDownload(url, savePath, forceDownload: forceDownload);

  /// 取消下载任务
  void cancelDownload(String url) => _notifier.cancelDownload(url);

  /// 暂停下载任务
  void pauseDownload(String url) => _notifier.pauseDownload(url);

  /// 恢复下载任务
  void resumeDownload(String url) => _notifier.resumeDownload(url);

  /// 移除下载任务
  void removeDownload(String url) => _notifier.removeDownload(url);

  /// 获取所有下载任务
  List<DownloadTask> getAllDownloads() => _notifier.getAllDownloads();

  /// 取消所有下载任务
  void cancelAllDownloads() => _notifier.cancelAllDownloads();
}
