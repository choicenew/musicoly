import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/auth/user_interface.dart';
import '../models/youtube_user.dart';

/// YouTube Music用户适配器
///
/// 负责将YouTube Music特定的用户模型转换为应用程序通用的接口模型
@immutable
class YouTubeUserAdapter {
  /// 将YouTubeUser转换为UserInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为YouTubeUser已经实现了UserInterface接口
  static UserInterface toInterface(YouTubeUser user) {
    return user;
  }

  /// 将UserInterface转换为YouTubeUser
  ///
  /// 如果传入的user已经是YouTubeUser类型，则直接返回
  /// 否则，创建一个新的YouTubeUser实例
  static YouTubeUser fromInterface(UserInterface user) {
    if (user is YouTubeUser) {
      return user;
    }

    return YouTubeUser(
      id: user.id,
      displayName: user.displayName,
      email: user.email,
      imageUrl: user.imageUrl,
      country: user.country,
      followersCount: user.followersCount,
      subscriptionType: user.subscriptionType,
      platformMetadata: user.platformMetadata ?? {},
    );
  }
}
