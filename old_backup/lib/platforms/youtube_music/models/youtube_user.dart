import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/auth/user_interface.dart';

/// YouTube Music用户模型 - 实现UserInterface接口
@immutable
class YouTubeUser implements UserInterface {
  /// 构造函数
  const YouTubeUser({
    required this.id,
    required this.displayName,
    this.email,
    this.imageUrl,
    this.country,
    this.followersCount,
    this.subscriptionType,
    this.platformMetadata = const {},
  });

  /// 从JSON创建YouTubeUser实例
  factory YouTubeUser.fromJson(Map<String, dynamic> json) {
    return YouTubeUser(
      id: json['channelId'] as String? ?? json['id'] as String,
      displayName: json['name'] as String,
      email: json['email'] as String?,
      imageUrl: json['thumbnailUrl'] as String? ?? json['thumbnail'] as String?,
      country: json['country'] as String?,
      followersCount: json['subscriberCount'] as int?,
      subscriptionType: json['subscriptionType'] as String?,
      platformMetadata: json,
    );
  }

  @override
  final String id;

  @override
  final String displayName;

  @override
  final String? email;

  @override
  final String? imageUrl;

  @override
  final String? country;

  @override
  final int? followersCount;

  @override
  final String? subscriptionType;

  @override
  final Map<String, dynamic> platformMetadata;

  @override
  String get platform => 'youtube_music';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'email': email,
      'image_url': imageUrl,
      'country': country,
      'followers_count': followersCount,
      'subscription_type': subscriptionType,
      'platform': platform,
      'platform_metadata': platformMetadata,
    };
  }

  /// 创建YouTubeUser的副本
  YouTubeUser copyWith({
    String? id,
    String? displayName,
    String? email,
    String? imageUrl,
    String? country,
    int? followersCount,
    String? subscriptionType,
    Map<String, dynamic>? platformMetadata,
  }) {
    return YouTubeUser(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      country: country ?? this.country,
      followersCount: followersCount ?? this.followersCount,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      platformMetadata: platformMetadata ?? this.platformMetadata,
    );
  }
}
