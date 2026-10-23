import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/features/lyrics/providers/lyrics_provider.dart';
import 'package:pyro_music/features/lyrics/providers/synced_lyrics_provider.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

/// 歌词控制器
class LyricsController {
  final LyricsProvider _lyricsProvider;
  final SyncedLyricsProvider _syncedLyricsProvider;
  final Ref _ref;
  late final PlayerStateNotifier _playerStateNotifier;

  /// 构造函数
  LyricsController(
    this._lyricsProvider,
    this._syncedLyricsProvider,
    this._ref,
  ) {
    // Get the PlayerStateNotifier instance
    _playerStateNotifier = _ref.read(playerStateProvider.notifier);
    
    // 监听播放器状态变化
    _playerStateNotifier.currentTrack.addListener(_onTrackChanged);
    _playerStateNotifier.position.addListener(_onPositionChanged);
  }

  /// 当前歌词
  ValueNotifier<LyricsInterface?> get currentLyrics =>
      _lyricsProvider.currentLyrics;

  /// 当前歌词索引
  ValueNotifier<int> get currentLyricIndex => _lyricsProvider.currentLyricIndex;

  /// 当前播放位置
  ValueNotifier<int> get currentPosition => _lyricsProvider.currentPosition;

  /// 是否显示同步歌词
  ValueNotifier<bool> get showSyncedLyrics => _lyricsProvider.showSyncedLyrics;

  /// 是否编辑模式
  ValueNotifier<bool> get isEditMode => _lyricsProvider.isEditMode;

  /// 自动滚动
  ValueNotifier<bool> get autoScroll => _syncedLyricsProvider.autoScroll;

  /// 高亮当前行
  ValueNotifier<bool> get highlightCurrentLine =>
      _syncedLyricsProvider.highlightCurrentLine;

  /// 显示翻译
  ValueNotifier<bool> get showTranslation =>
      _syncedLyricsProvider.showTranslation;

  /// 字体大小
  ValueNotifier<double> get fontSize => _syncedLyricsProvider.fontSize;

  /// 行间距
  ValueNotifier<double> get lineSpacing => _syncedLyricsProvider.lineSpacing;

  /// 曲目变化处理
  void _onTrackChanged() {
    final track = _playerStateNotifier.currentTrack.value;
    if (track == null) {
      _lyricsProvider.clearLyrics();
      return;
    }

    // 加载歌词
    _loadLyrics(track);
  }

  /// 播放位置变化处理
  void _onPositionChanged() {
    final position = _playerStateNotifier.position.value;
    _lyricsProvider.updatePosition(position);
  }

  /// 加载歌词
  Future<void> _loadLyrics(TrackInterface track) async {
    // 优先尝试加载同步歌词
    if (showSyncedLyrics.value) {
      final syncedLyrics = await _lyricsProvider.loadSyncedLyrics(track);
      if (syncedLyrics != null) return;
    }

    // 如果没有同步歌词或不显示同步歌词，加载普通歌词
    await _lyricsProvider.loadLyrics(track);
  }

  /// 切换同步歌词显示
  void toggleSyncedLyrics() {
    _lyricsProvider.toggleSyncedLyrics();

    // 重新加载当前曲目的歌词
    final track = _playerStateNotifier.currentTrack.value;
    if (track != null) {
      _loadLyrics(track);
    }
  }

  /// 切换自动滚动
  void toggleAutoScroll() {
    _syncedLyricsProvider.toggleAutoScroll();
  }

  /// 切换高亮当前行
  void toggleHighlightCurrentLine() {
    _syncedLyricsProvider.toggleHighlightCurrentLine();
  }

  /// 切换显示翻译
  void toggleShowTranslation() {
    _syncedLyricsProvider.toggleShowTranslation();
  }

  /// 切换编辑模式
  void toggleEditMode() {
    _lyricsProvider.toggleEditMode();
  }

  /// 设置字体大小
  void setFontSize(double size) {
    _syncedLyricsProvider.setFontSize(size);
  }

  /// 设置行间距
  void setLineSpacing(double spacing) {
    _syncedLyricsProvider.setLineSpacing(spacing);
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, int newTimestamp) async {
    await _lyricsProvider.adjustLyricTimestamp(index, newTimestamp);
  }

  /// 导出LRC格式歌词
  String exportToLRC() {
    return _lyricsProvider.exportToLRC();
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
    return await _lyricsProvider.importFromLRC(lrcContent, track);
  }

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    return await _lyricsProvider.searchLyrics(query,
        limit: limit, offset: offset);
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    return await _lyricsProvider.saveLyrics(lyrics);
  }

  /// 释放资源
  void dispose() {
    _playerStateNotifier.currentTrack.removeListener(_onTrackChanged);
    _playerStateNotifier.position.removeListener(_onPositionChanged);
  }
}
