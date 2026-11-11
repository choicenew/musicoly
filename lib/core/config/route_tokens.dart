import 'package:flutter/foundation.dart';

/// 强类型路由 Token 标识符定义 (遵循 Prohibit String Literals Protocol & Naming Convention Protocol)
@immutable
class RouteTokens {
  const RouteTokens._();

  static const String home = '/';
  static const String search = '/search';
  static const String settings = '/settings';
  static const String cacheSettings = '/cache-settings';
  static const String stats = '/stats';
  static const String localMusic = '/local-music';
  static const String favorites = '/favorites';
  static const String album = '/album/:id';
  static const String artist = '/artist/:id';
  static const String playlist = '/playlist/:id';
  static const String lyrics = '/lyrics';
  static const String player = '/player';
}
