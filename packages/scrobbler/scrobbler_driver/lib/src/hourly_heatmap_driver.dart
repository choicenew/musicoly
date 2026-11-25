import 'package:scrobbler_protocol/scrobbler_protocol.dart';

/// 24-Hour Listening Habits & Hourly Heatmap Scrobbler Driver (Namida & InnerTune Inspired)
class HourlyHeatmapDriver implements ScrobblerDriver {
  @override
  String get serviceId => 'hourly_heatmap_stats';

  @override
  String get serviceName => '24-Hour Listening Habits Heatmap';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isAuthenticated() async => true;

  @override
  Future<bool> authenticate() async => true;

  @override
  Future<void> logout() async {}

  @override
  Future<bool> scrobble(PlayHistoryEntity history) async {
    // Record listening timestamp for 24h heatmap
    return true;
  }

  @override
  Future<bool> updateNowPlaying(PlayHistoryEntity history) async => true;

  @override
  Future<void> dispose() async {}
}
