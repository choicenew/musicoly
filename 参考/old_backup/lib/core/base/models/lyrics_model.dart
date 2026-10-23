import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/models/base_model.dart';

/// 歌词模型
class LyricsModel extends BaseModel implements LyricsInterface {
  @override
  final String id;

  @override
  final TrackInterface track;

  @override
  final String text;

  @override
  final bool isSynced;

  @override
  final List<List<dynamic>> syncedLyrics;

  @override
  final String? language;

  @override
  final String? source;

  const LyricsModel({
    required this.id,
    required this.track,
    required this.text,
    this.isSynced = false,
    this.syncedLyrics = const [],
    this.language,
    this.source,
  }) : super(id: id, platform: 'pyro_music');

  /// 从JSON创建歌词模型
  factory LyricsModel.fromJson(
      Map<String, dynamic> json, TrackInterface track) {
    return LyricsModel(
      id: json['id'] as String,
      track: track,
      text: json['text'] as String,
      isSynced: json['isSynced'] as bool? ?? false,
      syncedLyrics: (json['syncedLyrics'] as List<dynamic>?)
              ?.map((e) => e as List<dynamic>)
              .toList() ??
          [],
      language: json['language'] as String?,
      source: json['source'] as String?,
    );
  }

  /// 转换为JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackId': track.id,
      'text': text,
      'isSynced': isSynced,
      'syncedLyrics': syncedLyrics,
      'language': language,
      'source': source,
    };
  }

  /// 创建副本
  @override
  BaseModel copyWith({
    String? id,
    String? platform,
    TrackInterface? track,
    String? text,
    bool? isSynced,
    List<List<dynamic>>? syncedLyrics,
    String? language,
    String? source,
  }) {
    return LyricsModel(
      id: id ?? this.id,
      track: track ?? this.track,
      text: text ?? this.text,
      isSynced: isSynced ?? this.isSynced,
      syncedLyrics: syncedLyrics ?? this.syncedLyrics,
      language: language ?? this.language,
      source: source ?? this.source,
    );
    // platform parameter is ignored as it's fixed to 'pyro_music' in constructor
  }
}
