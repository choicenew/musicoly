import 'package:pyro_music/features/download_manager/models/download_models.dart';

abstract class DownloadManagerService {
  Stream<DownloadStatusEvent> get statusStream;
  Future<void> enqueue(DownloadRequest request);
  Future<void> pause(String taskId);
  Future<void> resume(String taskId);
  Future<void> cancel(String taskId);
  List<DownloadTask> getAllTasks();
  DownloadTask? getTask(String taskId);
  void dispose();
}
