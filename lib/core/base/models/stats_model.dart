import 'package:pyro_music/core/base/interfaces/stats/play_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/stats/artist_stats_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/artist_interface.dart';
import 'package:pyro_music/core/base/models/base_model.dart';

/// 播放统计模型
class PlayStatsModel extends BaseModel implements PlayStatsInterface {
  @override
  final TrackInterface track;

  @override
  final int playCount;

  @override
  final DateTime firstPlayed;

  @override
  final DateTime lastPlayed;

  @override
  final int playDuration;

  @override
  final bool isCompletePlay;

  @override
  final int skipCount;

  const PlayStatsModel({
    required super.id,
    required this.track,
    this.playCount = 1,
    required this.firstPlayed,
    required this.lastPlayed,
    this.playDuration = 0,
    this.isCompletePlay = false,
    this.skipCount = 0,
    required super.platform,
  });

  /// 从JSON创建播放统计模型
  factory PlayStatsModel.fromJson(
      Map<String, dynamic> json, TrackInterface track) {
    return PlayStatsModel(
      id: json['id'] as String,
      track: track,
      playCount: json['playCount'] as int? ?? 1,
      firstPlayed: DateTime.parse(json['firstPlayed'] as String),
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      playDuration: json['playDuration'] as int? ?? 0,
      isCompletePlay: json['isCompletePlay'] as bool? ?? false,
      skipCount: json['skipCount'] as int? ?? 0,
      platform: json['platform'] as String,
    );
  }

  /// 转换为JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackId': track.id,
      'playCount': playCount,
      'firstPlayed': firstPlayed.toIso8601String(),
      'lastPlayed': lastPlayed.toIso8601String(),
      'playDuration': playDuration,
      'isCompletePlay': isCompletePlay,
      'skipCount': skipCount,
    };
  }

  /// 创建副本
  @override
  PlayStatsModel copyWith({
    String? id,
    TrackInterface? track,
    int? playCount,
    DateTime? firstPlayed,
    DateTime? lastPlayed,
    int? playDuration,
    bool? isCompletePlay,
    int? skipCount,
    String? platform,
  }) {
    return PlayStatsModel(
      id: id ?? this.id,
      track: track ?? this.track,
      playCount: playCount ?? this.playCount,
      firstPlayed: firstPlayed ?? this.firstPlayed,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      playDuration: playDuration ?? this.playDuration,
      isCompletePlay: isCompletePlay ?? this.isCompletePlay,
      skipCount: skipCount ?? this.skipCount,
      platform: platform ?? this.platform,
    );
  }
}

/// 艺术家统计模型
class ArtistStatsModel extends BaseModel implements ArtistStatsInterface {
  @override
  final ArtistInterface artist;

  @override
  final int playCount;

  @override
  final DateTime firstPlayed;

  @override
  final DateTime lastPlayed;

  @override
  final int totalPlayDuration;

  const ArtistStatsModel({
    required super.id,
    required this.artist,
    this.playCount = 1,
    required this.firstPlayed,
    required this.lastPlayed,
    this.totalPlayDuration = 0,
    super.platform = 'default',
  });

  /// 从JSON创建艺术家统计模型
  factory ArtistStatsModel.fromJson(
      Map<String, dynamic> json, ArtistInterface artist) {
    return ArtistStatsModel(
      id: json['id'] as String,
      artist: artist,
      playCount: json['playCount'] as int? ?? 1,
      firstPlayed: DateTime.parse(json['firstPlayed'] as String),
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      totalPlayDuration: json['totalPlayDuration'] as int? ?? 0,
      platform: json['platform'] as String,
    );
  }

  /// 转换为JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artistId': artist.id,
      'playCount': playCount,
      'firstPlayed': firstPlayed.toIso8601String(),
      'lastPlayed': lastPlayed.toIso8601String(),
      'totalPlayDuration': totalPlayDuration,
    };
  }

  /// 创建副本
  @override
  ArtistStatsModel copyWith({
    String? id,
    ArtistInterface? artist,
    int? playCount,
    DateTime? firstPlayed,
    DateTime? lastPlayed,
    int? totalPlayDuration,
    String? platform,
  }) {
    return ArtistStatsModel(
      id: id ?? this.id,
      artist: artist ?? this.artist,
      playCount: playCount ?? this.playCount,
      firstPlayed: firstPlayed ?? this.firstPlayed,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      totalPlayDuration: totalPlayDuration ?? this.totalPlayDuration,
      platform: platform ?? this.platform,
    );
  }
}
