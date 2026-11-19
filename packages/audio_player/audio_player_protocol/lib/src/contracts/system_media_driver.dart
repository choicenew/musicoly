abstract class SystemMediaDriver {
  Future<void> updateMetadata({required String title, required String artist, String? artworkUrl});
  Future<void> updatePlaybackState({required bool isPlaying, required Duration position});
}
