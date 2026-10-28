import 'package:pyro_music/core/services/base_service.dart';

abstract class QueueInterface extends BaseService {
  Future<void> addTrack(String trackId);
  Future<void> addTracks(List<String> trackIds);
  Future<void> removeTrack(String trackId);
  Future<void> removeTrackAt(int index);
  Future<void> clearQueue();
  Future<List<String>> getQueue();
  Future<int> getCurrentIndex();
  Future<void> moveTrack(int oldIndex, int newIndex);
  Future<void> skipToIndex(int index);
  Future<void> replaceQueue(List<String> trackIds, {int startIndex = 0});
  Future<List<String>> getHistory();
  Future<void> clearHistory();
}

abstract class QueueService extends BaseService implements QueueInterface {}
