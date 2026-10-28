import 'package:flutter/foundation.dart';
import 'package:pyro_music/features/track_source/contracts/track_source_contract.dart';

@immutable
class SourceInfoModel implements SourceInfo {
  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String? album;
  @override
  final String? url;
  @override
  final String thumbnailUrl;
  @override
  final Duration duration;
  @override
  final SourceQualities quality;
  @override
  final SourceCodecs codec;

  const SourceInfoModel({
    required this.id,
    required this.title,
    required this.artist,
    this.album,
    this.url,
    this.thumbnailUrl = '',
    this.duration = Duration.zero,
    this.quality = SourceQualities.high,
    this.codec = SourceCodecs.m4a,
  });
}
