import 'package:flutter/foundation.dart';
import 'package:scrobbler_protocol/scrobbler_protocol.dart';

/// 24-Hour Listening Habits & Hourly Heatmap Scrobbler Driver (Namida & InnerTune Inspired)
class HourlyHeatmapDriver implements ScrobblerDriver {
  final Map<int, int> _hourlyPlayCounts = {for (var i = 0; i < 24; i++) i: 0};

  @override
  String get serviceId => 'hourly_heatmap_stats';

  @override
  String get serviceName => '24-Hour Listening Habits Heatmap & Statistics';

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
    final hour = history.playedAt.hour;
    _hourlyPlayCounts[hour] = (_hourlyPlayCounts[hour] ?? 0) + 1;
    debugPrint('Recorded play at hour $hour. Total for hour: ${_hourlyPlayCounts[hour]}');
    return true;
  }

  @override
  Future<bool> updateNowPlaying(PlayHistoryEntity history) async => true;

  Map<int, int> getHourlyHeatmapData() => Map.unmodifiable(_hourlyPlayCounts);

  @override
  Future<void> dispose() async {}
}
