import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/core/base/interfaces/download_manager/download_manager_interface.dart';
import 'package:pyro_music/features/download_manager/providers/download_provider.dart';

/// 下载控制器
class DownloadController {
  final BuildContext context;

  DownloadController(this.context);

  /// 获取下载提供者
  DownloadProvider get _provider => context.read<DownloadProvider>();

  /// 获取下载状态流
  Stream<DownloadStatusEvent> get statusStream => _provider.statusStream;

  /// 获取下载任务
  DownloadTask? getDownload(String url) => _provider.getDownload(url);

  /// 添加下载任务
  Future<DownloadTask?> addDownload(String url, String savePath,
          {bool forceDownload = false}) =>
      _provider.addDownload(url, savePath, forceDownload: forceDownload);

  /// 取消下载任务
  void cancelDownload(String url) => _provider.cancelDownload(url);

  /// 暂停下载任务
  void pauseDownload(String url) => _provider.pauseDownload(url);

  /// 恢复下载任务
  void resumeDownload(String url) => _provider.resumeDownload(url);

  /// 移除下载任务
  void removeDownload(String url) => _provider.removeDownload(url);

  /// 获取所有下载任务
  List<DownloadTask> getAllDownloads() => _provider.getAllDownloads();

  /// 取消所有下载任务
  void cancelAllDownloads() => _provider.cancelAllDownloads();

  /// 工厂方法，从上下文创建控制器
  static DownloadController of(BuildContext context) {
    return DownloadController(context);
  }
}
