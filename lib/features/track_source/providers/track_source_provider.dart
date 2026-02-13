import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/features/track_source/services/track_source_service_impl.dart';

part 'track_source_provider.freezed.dart';
part 'track_source_provider.g.dart';

/// TrackSource state data class
@freezed
abstract class TrackSourceState with _$TrackSourceState {
  const factory TrackSourceState({
    @Default(AudioSource.youtube) AudioSource currentSource,
    @Default(SourceQualities.high) SourceQualities quality,
    @Default(SourceCodecs.m4a) SourceCodecs codec,
  }) = _TrackSourceState;
}

/// 音轨源提供者实现
@Riverpod(keepAlive: true)
class TrackSourceNotifier extends _$TrackSourceNotifier {
  late final TrackSourceServiceImpl _service;

  @override
  TrackSourceState build() {
    _service = TrackSourceServiceImpl();
    // Initialize state from service
    return TrackSourceState(
      currentSource: _service.currentSource,
      quality: _service.quality,
      codec: _service.codec,
    );
  }

  void setSource(AudioSource source) {
    _service.setSource(source);
    state = state.copyWith(currentSource: source);
  }

  void setQuality(SourceQualities quality) {
    _service.setQuality(quality);
    state = state.copyWith(quality: quality);
  }

  void setCodec(SourceCodecs codec) {
    _service.setCodec(codec);
    state = state.copyWith(codec: codec);
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
