import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';

enum SourceQualities {
  low,
  medium,
  high,
}

enum SourceCodecs {
  m4a,
  opus,
  webm,
  mp3,
  flac,
  wav,
}

/// 音轨源信息接口
abstract class SourceInfo {
  String get id;
  String get title;
  String get artist;
  String get thumbnailUrl;
  Duration get duration;
  String get sourceId; // 使用 String 代替枚举以支持插件化
  String? get url; // 可选的流媒体URL
}

/// 音轨源接口
abstract class TrackSourceInterface {
  /// 获取当前活跃的插件ID
  String get activePluginId;

  /// 音频质量
  SourceQualities get quality;

  /// 音频编解码器
  SourceCodecs get codec;

  /// 从轨道获取音源
  Future<SourcedTrack> fetchFromTrack({required TrackInterface track});

  /// 从备选音源获取轨道
  Future<SourcedTrack> fetchFromTrackAltSource({required TrackInterface track});

  /// 搜索音源
  Future<List<SourceInfo>> search(String query);

  /// 设置当前音频源插件
  void setSource(String sourceId);

  /// 设置音频质量
  void setQuality(SourceQualities quality);

  /// 设置音频编解码器
  void setCodec(SourceCodecs codec);
}

/// 带有音源的轨道接口
abstract class SourcedTrack {
  TrackInterface get track;
  SourceInfo get sourceInfo;
  List<SourceInfo> get siblings;
  String get sourceId;
  SourceCodecs get codec;
}
