import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/features/lyrics/providers/lyrics_provider.dart';
import 'package:pyro_music/features/lyrics/providers/synced_lyrics_provider.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

final lyricsControllerProvider = Provider((ref) => LyricsController(ref));

/// 歌词控制器
class LyricsController {
  final Ref _ref;

  /// Provider for the lyrics controller
  static final provider = lyricsControllerProvider;

  /// 当前歌词
  final ValueNotifier<LyricsInterface?> currentLyrics = ValueNotifier(null);

  /// 当前歌词索引
  final ValueNotifier<int> currentLyricIndex = ValueNotifier(-1);

  /// 当前播放位置
  final ValueNotifier<int> currentPosition = ValueNotifier(0);

  /// 是否显示同步歌词
  final ValueNotifier<bool> showSyncedLyrics = ValueNotifier(true);

  /// 是否编辑模式
  final ValueNotifier<bool> isEditMode = ValueNotifier(false);

  /// 自动滚动
  final ValueNotifier<bool> autoScroll = ValueNotifier(true);

  /// 高亮当前行
  final ValueNotifier<bool> highlightCurrentLine = ValueNotifier(true);

  /// 显示翻译
  final ValueNotifier<bool> showTranslation = ValueNotifier(false);

  /// 字体大小
  final ValueNotifier<double> fontSize = ValueNotifier(16.0);

  /// 行间距
  final ValueNotifier<double> lineSpacing = ValueNotifier(1.5);

  /// 构造函数
  LyricsController(this._ref) {
    _initListeners();
  }

  void _initListeners() {
    // Listen to LyricsNotifier state
    _ref.listen(lyricsProvider, (previous, next) {
      if (previous?.currentLyrics != next.currentLyrics) {
        currentLyrics.value = next.currentLyrics;
      }
      if (previous?.currentLyricIndex != next.currentLyricIndex) {
        currentLyricIndex.value = next.currentLyricIndex;
      }
      if (previous?.currentPosition != next.currentPosition) {
        currentPosition.value = next.currentPosition;
      }
      if (previous?.showSyncedLyrics != next.showSyncedLyrics) {
        showSyncedLyrics.value = next.showSyncedLyrics;
      }
      if (previous?.isEditMode != next.isEditMode) {
        isEditMode.value = next.isEditMode;
      }
    });

    // Listen to SyncedLyricsNotifier state
    _ref.listen(syncedLyricsProvider, (previous, next) {
      if (previous?.autoScroll != next.autoScroll) {
        autoScroll.value = next.autoScroll;
      }
      if (previous?.highlightCurrentLine != next.highlightCurrentLine) {
        highlightCurrentLine.value = next.highlightCurrentLine;
      }
      if (previous?.showTranslation != next.showTranslation) {
        showTranslation.value = next.showTranslation;
      }
      if (previous?.fontSize != next.fontSize) {
        fontSize.value = next.fontSize;
      }
      if (previous?.lineSpacing != next.lineSpacing) {
        lineSpacing.value = next.lineSpacing;
      }
    });

    // Listen to PlayerState for track changes
    _ref.listen(playerStateProvider, (previous, next) {
      if (previous?.currentTrack != next.currentTrack) {
        _onTrackChanged(next.currentTrack);
      }
      if (previous?.position != next.position) {
         _onPositionChanged(next.position);
      }
    });
  }

  /// 曲目变化处理
  void _onTrackChanged(TrackInterface? track) {
    if (track == null) {
      _ref.read(lyricsProvider.notifier).clearLyrics();
      return;
    }

    // 加载歌词
    _loadLyrics(track);
  }

  /// 播放位置变化处理
  void _onPositionChanged(int position) {
    _ref.read(lyricsProvider.notifier).updatePosition(position);
  }

  /// 加载歌词
  Future<void> _loadLyrics(TrackInterface track) async {
    // 优先尝试加载同步歌词
    if (showSyncedLyrics.value) {
      await _ref.read(lyricsProvider.notifier).loadSyncedLyrics(track);
      // Check if loaded successfully? The notifier updates state, and we listen to it.
      // But we need to know if we should fallback.
      // Accessing state directly:
      final lyrics = _ref.read(lyricsProvider).currentLyrics;
      if (lyrics != null && lyrics.isSynced) return;
    }

    // 如果没有同步歌词或不显示同步歌词，加载普通歌词
    await _ref.read(lyricsProvider.notifier).loadLyrics(track);
  }

  /// 切换同步歌词显示
  void toggleSyncedLyrics() {
    _ref.read(lyricsProvider.notifier).toggleSyncedLyrics();

    // 重新加载当前曲目的歌词
    final track = _ref.read(playerStateProvider).currentTrack;
    if (track != null) {
      _loadLyrics(track);
    }
  }

  /// 切换自动滚动
  void toggleAutoScroll() {
    _ref.read(syncedLyricsProvider.notifier).toggleAutoScroll();
  }

  /// 切换高亮当前行
  void toggleHighlightCurrentLine() {
    _ref.read(syncedLyricsProvider.notifier).toggleHighlightCurrentLine();
  }

  /// 切换显示翻译
  void toggleShowTranslation() {
    _ref.read(syncedLyricsProvider.notifier).toggleShowTranslation();
  }

  /// 切换编辑模式
  void toggleEditMode() {
    _ref.read(lyricsProvider.notifier).toggleEditMode();
  }

  /// 设置字体大小
  void setFontSize(double size) {
    _ref.read(syncedLyricsProvider.notifier).setFontSize(size);
  }

  /// 设置行间距
  void setLineSpacing(double spacing) {
    _ref.read(syncedLyricsProvider.notifier).setLineSpacing(spacing);
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, int newTimestamp) async {
    await _ref.read(lyricsProvider.notifier).adjustLyricTimestamp(index, newTimestamp);
  }

  /// 导出LRC格式歌词
  String exportToLRC() {
    return _ref.read(lyricsProvider.notifier).exportToLRC();
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
    return await _ref.read(lyricsProvider.notifier).importFromLRC(lrcContent, track);
  }

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    return await _ref.read(lyricsProvider.notifier).searchLyrics(query,
        limit: limit, offset: offset);
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    return await _ref.read(lyricsProvider.notifier).saveLyrics(lyrics);
  }

  /// 释放资源
  void dispose() {
    currentLyrics.dispose();
    currentLyricIndex.dispose();
    currentPosition.dispose();
    showSyncedLyrics.dispose();
    isEditMode.dispose();
    autoScroll.dispose();
    highlightCurrentLine.dispose();
    showTranslation.dispose();
    fontSize.dispose();
    lineSpacing.dispose();
  }
}
