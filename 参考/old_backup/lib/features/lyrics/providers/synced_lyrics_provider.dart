import 'package:flutter/foundation.dart';
import 'package:pyro_music/features/lyrics/providers/lyrics_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';

/// 同步歌词提供者
class SyncedLyricsProvider {
  final LyricsProvider _lyricsProvider;

  /// 自动滚动
  ValueNotifier<bool> autoScroll = ValueNotifier(true);

  /// 高亮当前行
  ValueNotifier<bool> highlightCurrentLine = ValueNotifier(true);

  /// 显示翻译
  ValueNotifier<bool> showTranslation = ValueNotifier(false);

  /// 字体大小
  ValueNotifier<double> fontSize = ValueNotifier(16.0);

  /// 行间距
  ValueNotifier<double> lineSpacing = ValueNotifier(1.5);

  /// 构造函数
  SyncedLyricsProvider(this._lyricsProvider);

  /// 获取当前歌词
  LyricsInterface? get currentLyrics => _lyricsProvider.currentLyrics.value;

  /// 获取当前歌词索引
  int get currentLyricIndex => _lyricsProvider.currentLyricIndex.value;

  /// 获取当前播放位置
  int get currentPosition => _lyricsProvider.currentPosition.value;

  /// 是否显示同步歌词
  bool get showSyncedLyrics => _lyricsProvider.showSyncedLyrics.value;

  /// 切换自动滚动
  void toggleAutoScroll() {
    autoScroll.value = !autoScroll.value;
  }

  /// 切换高亮当前行
  void toggleHighlightCurrentLine() {
    highlightCurrentLine.value = !highlightCurrentLine.value;
  }

  /// 切换显示翻译
  void toggleShowTranslation() {
    showTranslation.value = !showTranslation.value;
  }

  /// 设置字体大小
  void setFontSize(double size) {
    fontSize.value = size;
  }

  /// 设置行间距
  void setLineSpacing(double spacing) {
    lineSpacing.value = spacing;
  }

  /// 获取指定索引的歌词文本
  String? getLyricText(int index) {
    if (currentLyrics == null ||
        !currentLyrics!.isSynced ||
        index < 0 ||
        index >= currentLyrics!.syncedLyrics.length) {
      return null;
    }

    return currentLyrics!.syncedLyrics[index][1] as String?;
  }

  /// 获取指定索引的歌词时间戳
  int? getLyricTimestamp(int index) {
    if (currentLyrics == null ||
        !currentLyrics!.isSynced ||
        index < 0 ||
        index >= currentLyrics!.syncedLyrics.length) {
      return null;
    }

    return currentLyrics!.syncedLyrics[index][0] as int?;
  }

  /// 格式化时间戳为时间字符串
  String formatTimestamp(int timestamp) {
    final minutes = (timestamp ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((timestamp % 60000) ~/ 1000).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// 释放资源
  void dispose() {
    autoScroll.dispose();
    highlightCurrentLine.dispose();
    showTranslation.dispose();
    fontSize.dispose();
    lineSpacing.dispose();
  }
}
