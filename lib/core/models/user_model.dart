import 'package:flutter/foundation.dart';
import 'base_model.dart';

@immutable
class UserModel extends BaseModel {
  final String displayName;
  final String? email;
  final String? imageUrl;
  final String? country;
  final int? followersCount;
  final String? subscriptionType;
  final Map<String, dynamic> platformMetadata;

  const UserModel({
    required super.id,
    required super.platform,
    required this.displayName,
    this.email,
    this.imageUrl,
    this.country,
    this.followersCount,
    this.subscriptionType,
    this.platformMetadata = const {},
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'displayName': displayName,
        'email': email,
        'imageUrl': imageUrl,
        'country': country,
        'followersCount': followersCount,
        'subscriptionType': subscriptionType,
        'platformMetadata': platformMetadata,
      };

  @override
  UserModel copyWith({
    String? id,
    String? platform,
    String? displayName,
    String? email,
    String? imageUrl,
    String? country,
    int? followersCount,
    String? subscriptionType,
    Map<String, dynamic>? platformMetadata,
  }) {
    return UserModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
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
