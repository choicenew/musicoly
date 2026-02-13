import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';
import 'package:pyro_music/core/base/services/lyrics_service.dart';
import 'package:pyro_music/features/lyrics/services/lyrics_service_impl.dart';
import 'package:pyro_music/features/lyrics/services/synced_lyrics_service_impl.dart';

part 'lyrics_provider.freezed.dart';
part 'lyrics_provider.g.dart';

@freezed
abstract class LyricsState with _$LyricsState {
  const factory LyricsState({
    LyricsInterface? currentLyrics,
    @Default(true) bool showSyncedLyrics,
    @Default(0) int currentPosition,
    @Default(-1) int currentLyricIndex,
    @Default(false) bool isEditMode,
    @Default(false) bool isLoading,
    String? error,
  }) = _LyricsState;
}

/// 歌词提供者实现
@Riverpod(keepAlive: true)
class LyricsNotifier extends _$LyricsNotifier {
  late final LyricsService _lyricsService;
  late final SyncedLyricsServiceImpl _syncedLyricsService;

  @override
  LyricsState build() {
    _lyricsService = ref.watch(lyricsServiceProvider);
    _syncedLyricsService = ref.watch(syncedLyricsServiceProvider);
    return const LyricsState();
  }

  /// 加载歌词
  Future<void> loadLyrics(TrackInterface track) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final lyrics = await _lyricsService.getLyrics(track);
      state = state.copyWith(currentLyrics: lyrics, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// 加载同步歌词
  Future<void> loadSyncedLyrics(TrackInterface track) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final lyrics = await _lyricsService.getSyncedLyrics(track);
      if (lyrics != null && lyrics.isSynced) {
        state = state.copyWith(currentLyrics: lyrics, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// 更新播放位置
  void updatePosition(int position) {
    int newIndex = state.currentLyricIndex;

    // 如果有同步歌词，更新当前歌词索引
    if (state.currentLyrics != null &&
        state.currentLyrics!.isSynced &&
        state.showSyncedLyrics) {
      newIndex = _syncedLyricsService.getCurrentLyricIndex(
          state.currentLyrics!, position);
    }

    state = state.copyWith(
      currentPosition: position,
      currentLyricIndex: newIndex,
    );
  }

  /// 获取下一行歌词的时间戳
  int getNextLyricTimestamp() {
    if (state.currentLyrics == null ||
        !state.currentLyrics!.isSynced ||
        state.currentLyricIndex < 0) {
      return -1;
    }

    return _syncedLyricsService.getNextLyricTimestamp(
        state.currentLyrics!, state.currentLyricIndex);
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, int newTimestamp) async {
    if (state.currentLyrics == null || !state.currentLyrics!.isSynced) return;

    final updatedLyrics = await _syncedLyricsService.adjustSyncedLyrics(
        state.currentLyrics!, index, newTimestamp);

    if (updatedLyrics != null) {
      state = state.copyWith(currentLyrics: updatedLyrics);
    }
  }

  /// 导出LRC格式歌词
  String exportToLRC() {
    if (state.currentLyrics == null || !state.currentLyrics!.isSynced) {
      return '';
    }

    return _syncedLyricsService.exportToLRC(state.currentLyrics!);
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
    final lyrics = await _syncedLyricsService.importFromLRC(lrcContent, track);
    if (lyrics != null) {
      state = state.copyWith(currentLyrics: lyrics);
      return true;
    }
    return false;
  }

  /// 切换编辑模式
  void toggleEditMode() {
    state = state.copyWith(isEditMode: !state.isEditMode);
  }

  /// 切换同步歌词显示
  void toggleSyncedLyrics() {
    state = state.copyWith(showSyncedLyrics: !state.showSyncedLyrics);
  }

  /// 搜索歌词
  Future<List<LyricsInterface>> searchLyrics(String query, {int limit = 10, int offset = 0}) async {
    try {
      return await _lyricsService.searchLyrics(query, limit: limit, offset: offset);
    } catch (e) {
      return [];
    }
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricsInterface lyrics) async {
    try {
      return await _lyricsService.saveLyrics(lyrics);
    } catch (e) {
      return false;
    }
  }

  /// 清除当前歌词
  void clearLyrics() {
    state = state.copyWith(currentLyrics: null, currentLyricIndex: -1);
  }
}
