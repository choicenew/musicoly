import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/auth/user_interface.dart';

/// Spotify用户模型 - 实现UserInterface接口
@immutable
class SpotifyUser implements UserInterface {
  /// 构造函数
  const SpotifyUser({
    required this.id,
    required this.displayName,
    this.email,
    this.imageUrl,
    this.country,
    this.followersCount,
    this.subscriptionType,
    this.platformMetadata = const {},
  });

  /// 从JSON创建SpotifyUser实例
  factory SpotifyUser.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    String? imageUrl;
    if (images != null && images.isNotEmpty) {
      imageUrl = (images.first as Map<String, dynamic>)['url'] as String?;
    }

    final followers = json['followers'] as Map<String, dynamic>?;
    final followersCount = followers?['total'] as int?;

    return SpotifyUser(
      id: json['id'] as String,
      displayName: json['display_name'] as String? ?? 'Unknown User',
      email: json['email'] as String?,
      imageUrl: imageUrl,
      country: json['country'] as String?,
      followersCount: followersCount,
      subscriptionType: json['product'] as String?,
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
  String get platform => 'spotify';

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

  /// 创建SpotifyUser的副本
  SpotifyUser copyWith({
    String? id,
    String? displayName,
    String? email,
    String? imageUrl,
    String? country,
    int? followersCount,
    String? subscriptionType,
    Map<String, dynamic>? platformMetadata,
  }) {
    return SpotifyUser(
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
