import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:lyric_protocol/lyric_protocol.dart';

class LyricHubImpl {
  final LinkedHashMap<String, List<LyricLineEntity>> _cache = LinkedHashMap();
  final List<LyricSourceDriver> _drivers = [];

  void registerDriver(LyricSourceDriver driver) {
    _drivers.add(driver);
  }

  Future<List<LyricLineEntity>> getLyrics(String trackId, {String? trackName, String? artistName}) async {
    if (_cache.containsKey(trackId)) {
      final cached = _cache.remove(trackId)!;
      _cache[trackId] = cached;
      return cached;
    }

    for (var driver in _drivers) {
      final lines = await driver.fetchLyrics(trackId, trackName: trackName, artistName: artistName);
      if (lines.isNotEmpty) {
        _cache[trackId] = lines;
        return lines;
      }
    }
    return [];
  }
}
