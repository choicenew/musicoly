import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/interfaces/download_manager/download_manager_interface.dart';

/// 下载管理器提供者接口
abstract class DownloadManagerProvider extends ChangeNotifier {
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
