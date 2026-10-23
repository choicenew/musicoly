import 'package:flutter/foundation.dart';
import 'media_model.dart';

enum HomeSectionType {
  banner,
  carousel,
  grid,
  trackList,
  quickActions,
  adBanner,
  adCard,
}

@immutable
class HomeSectionModel {
  final String id;
  final String title;
  final String? subtitle;
  final HomeSectionType type;
  final List<MediaModel> items;
  final Map<String, dynamic> extra;
  final bool isAdSection;

  const HomeSectionModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    this.items = const [],
    this.extra = const {},
    this.isAdSection = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'type': type.name,
        'items': items.map((i) => i.toJson()).toList(),
        'extra': extra,
        'isAdSection': isAdSection,
      };
}
