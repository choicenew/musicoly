import 'package:flutter/foundation.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';

@immutable
class SourceInfoModel implements SourceInfo {
  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String thumbnailUrl;
  @override
  final Duration duration;
  @override
  final String sourceId;
  @override
  final String? url;

  const SourceInfoModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.duration,
    required this.sourceId,
    this.url,
  });
}
