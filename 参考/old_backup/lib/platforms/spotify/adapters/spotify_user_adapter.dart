import 'package:flutter/foundation.dart';

import '../../../core/base/interfaces/auth/user_interface.dart';
import '../models/spotify_user.dart';

/// Spotify用户适配器
///
/// 负责将Spotify特定的用户模型转换为应用程序通用的接口模型
@immutable
class SpotifyUserAdapter {
  /// 将SpotifyUser转换为UserInterface
  ///
  /// 这个方法不需要进行复杂的转换，因为SpotifyUser已经实现了UserInterface接口
  static UserInterface toInterface(SpotifyUser user) {
    return user;
  }

  /// 将UserInterface转换为SpotifyUser
  ///
  /// 如果传入的user已经是SpotifyUser类型，则直接返回
  /// 否则，创建一个新的SpotifyUser实例
  static SpotifyUser fromInterface(UserInterface user) {
    if (user is SpotifyUser) {
      return user;
    }

    return SpotifyUser(
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
