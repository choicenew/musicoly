import 'package:flutter/foundation.dart';

@immutable
class SponsorSegmentEntity {
  final String category;
  final Duration startTime;
  final Duration endTime;

  const SponsorSegmentEntity({
    required this.category,
    required this.startTime,
    required this.endTime,
  });
}
