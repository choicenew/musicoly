import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/track_source/track_source_interface.dart';
import 'package:pyro_music/core/base/models/track_source_model.dart';
import 'package:pyro_music/core/base/services/track_source_service.dart';
import 'package:pyro_music/features/track_source/sources/youtube.dart';
import 'package:pyro_music/features/track_source/sources/piped.dart';
import 'package:pyro_music/features/track_source/sources/invidious.dart';
import 'package:pyro_music/features/track_source/sources/jiosaavn.dart';
import 'package:pyro_music/features/track_source/sources/soundcloud.dart';

/// 音轨源服务实现
class TrackSourceServiceImpl implements TrackSourceService {
  AudioSource _currentSource = AudioSource.youtube;
  SourceQualities _quality = SourceQualities.high;
  SourceCodecs _codec = SourceCodecs.opus;

  static final TrackSourceServiceImpl _instance = TrackSourceServiceImpl._();
  factory TrackSourceServiceImpl() => _instance;
  TrackSourceServiceImpl._();

  @override
  AudioSource get currentSource => _currentSource;

  @override
  SourceQualities get quality => _quality;

  @override
  SourceCodecs get codec => _codec;

  @override
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track}) async {
    try {
      // 根据当前音源调用不同平台的API获取音轨信息
      switch (_currentSource) {
        case AudioSource.youtube:
          return await YouTubeSource.fetchFromTrack(track: track);
        case AudioSource.piped:
          return await PipedSource.fetchFromTrack(track: track);
        case AudioSource.invidious:
          return await InvidiousSource.fetchFromTrack(track: track);
        case AudioSource.jiosaavn:
          return await JioSaavnSource.fetchFromTrack(track: track);
        case AudioSource.soundcloud:
          return await SoundcloudSource.fetchFromTrack(track: track);
      }
    } catch (e) {
      // 如果获取失败，尝试使用备选音源
      return await fetchFromTrackAltSource(track: track);
    }
  }

  @override
  Future<SourcedTrack> fetchFromTrackAltSource(
      {required TrackInterface track}) async {
    // 当主音源失败时，尝试使用备选音源
    final altSource = _getAlternativeSource(_currentSource);

    try {
      // 根据备选音源调用不同平台的API
      switch (altSource) {
        case AudioSource.youtube:
          return await YouTubeSource.fetchFromTrack(track: track);
        case AudioSource.piped:
          return await PipedSource.fetchFromTrack(track: track);
        case AudioSource.invidious:
          return await InvidiousSource.fetchFromTrack(track: track);
        case AudioSource.jiosaavn:
          return await JioSaavnSource.fetchFromTrack(track: track);
        case AudioSource.soundcloud:
          return await SoundcloudSource.fetchFromTrack(track: track);
      }
    } catch (e) {
      // 如果备选音源也失败，则创建一个基本的源轨道模型
      final sourceInfo = SourceInfoModel(
        id: 'alt-source-${track.id}',
        title: track.name,
        artist: track.artistNames.first,
        thumbnailUrl: track.imageUrl ?? '',
        duration: Duration(milliseconds: track.durationMs),
        source: altSource,
      );

      return SourcedTrackModel(
        track: track,
        sourceInfo: sourceInfo,
        siblings: [],
        source: altSource,
        codec: _codec,
      );
    }
  }

  @override
  Future<List<SourceInfo>> search(String query) async {
    // 根据当前音源调用不同平台的搜索API
    try {
      switch (_currentSource) {
        case AudioSource.youtube:
          return await YouTubeSource.search(query);
        case AudioSource.piped:
          return await PipedSource.search(query);
        case AudioSource.invidious:
          return await InvidiousSource.search(query);
        case AudioSource.jiosaavn:
          return await JioSaavnSource.search(query);
        case AudioSource.soundcloud:
          return await SoundcloudSource.search(query);
      }
    } catch (e) {
      return [];
    }
  }

  @override
  void setSource(AudioSource source) {
    _currentSource = source;
  }

  @override
  void setQuality(SourceQualities quality) {
    _quality = quality;
  }

  @override
  void setCodec(SourceCodecs codec) {
    _codec = codec;
  }

  // 获取备选音源
  AudioSource _getAlternativeSource(AudioSource source) {
    switch (source) {
      case AudioSource.youtube:
        return AudioSource.piped;
      case AudioSource.piped:
        return AudioSource.youtube;
      case AudioSource.jiosaavn:
        return AudioSource.youtube;
      case AudioSource.invidious:
        return AudioSource.youtube;
      case AudioSource.soundcloud:
        return AudioSource.youtube;
    }
  }
}
