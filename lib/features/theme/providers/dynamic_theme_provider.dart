import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_theme_provider.g.dart';

/// 动态主题状态 - 存储从封面提取的颜色
@riverpod
class DynamicThemeNotifier extends _$DynamicThemeNotifier {
  @override
  Color? build() {
    // 监听播放器状态中的当前曲目
    final playerState = ref.watch(playerStateProvider);
    final imageUrl = playerState.currentTrack?.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      _updateColor(imageUrl);
    }

    return null;
  }

  Future<void> _updateColor(String url) async {
    try {
      ImageProvider imageProvider;
      if (url.startsWith('file://')) {
        imageProvider = FileImage(File(url.replaceFirst('file://', '')));
      } else if (url.startsWith('http')) {
        imageProvider = NetworkImage(url);
      } else {
        // Assume local path if not http or file://
        imageProvider = FileImage(File(url));
      }

      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 10,
      );
      
      final color = paletteGenerator.dominantColor?.color ?? 
                    paletteGenerator.vibrantColor?.color ??
                    paletteGenerator.mutedColor?.color;
      
      if (color != null) {
        state = color;
      }
    } catch (e) {
      debugPrint('提取图片颜色失败: $e');
    }
  }
}
