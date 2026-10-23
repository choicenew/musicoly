import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/providers/track_source_provider.dart' as base;
import 'package:pyro_music/features/track_source/services/track_source_service_impl.dart';

/// 音轨源提供者实现
class TrackSourceProvider extends ChangeNotifier
    implements base.TrackSourceProvider {
  final TrackSourceServiceImpl _service;

  TrackSourceProvider({TrackSourceServiceImpl? service})
      : _service = service ?? TrackSourceServiceImpl();

  @override
  AudioSource get currentSource => _service.currentSource;

  @override
  SourceQualities get quality => _service.quality;

  @override
  SourceCodecs get codec => _service.codec;

  @override
  void setSource(AudioSource source) {
    _service.setSource(source);
    notifyListeners();
  }

  @override
  void setQuality(SourceQualities quality) {
    _service.setQuality(quality);
    notifyListeners();
  }

  @override
  void setCodec(SourceCodecs codec) {
    _service.setCodec(codec);
    notifyListeners();
  }

  /// 搜索音源
  Future<List<SourceInfo>> search(String query) {
    return _service.search(query);
  }

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required dynamic track}) {
    return _service.fetchFromTrack(track: track);
  }

  /// 从备选音源获取轨道
  Future<SourcedTrack> fetchFromTrackAltSource({required dynamic track}) {
    return _service.fetchFromTrackAltSource(track: track);
  }
}
