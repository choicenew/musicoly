import 'package:flutter/foundation.dart';
import 'media_model.dart';

enum AdCardShape {
  square,
  circle,
  tile,
  banner,
}

@immutable
class AdMediaModel extends MediaModel {
  final String sponsorTag;
  final String targetUrl;
  final AdCardShape cardShape;
  final bool isSponsor;

  const AdMediaModel({
    required super.id,
    super.platform = 'ad',
    required super.name,
    super.imageUrl,
    super.mediaType = MediaType.custom,
    super.description,
    super.tags,
    this.sponsorTag = 'Sponsor',
    required this.targetUrl,
    this.cardShape = AdCardShape.square,
    this.isSponsor = true,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'sponsorTag': sponsorTag,
        'targetUrl': targetUrl,
        'cardShape': cardShape.name,
        'isSponsor': isSponsor,
      };

  @override
  AdMediaModel copyWith({
    String? id,
    String? platform,
    String? name,
    String? imageUrl,
    MediaType? mediaType,
    String? description,
    List<String>? tags,
    String? sponsorTag,
    String? targetUrl,
    AdCardShape? cardShape,
    bool? isSponsor,
  }) {
    return AdMediaModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      sponsorTag: sponsorTag ?? this.sponsorTag,
      targetUrl: targetUrl ?? this.targetUrl,
      cardShape: cardShape ?? this.cardShape,
      isSponsor: isSponsor ?? this.isSponsor,
    );
  }
}
