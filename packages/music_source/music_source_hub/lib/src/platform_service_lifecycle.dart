abstract class PlatformServiceLifecycle {
  Future<void> initialize();
  Future<void> dispose();
  bool get isInitialized;
}
