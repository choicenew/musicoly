import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/base/providers/lyrics_provider.dart' as base;
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/features/lyrics/services/lyrics_service_impl.dart';
import 'package:pyro_music/features/lyrics/services/synced_lyrics_service_impl.dart';

/// 歌词提供者实现
class LyricsProvider extends base.LyricsProvider {
  final SyncedLyricsServiceImpl _syncedLyricsService;

  /// 当前播放位置(毫秒)
  ValueNotifier<int> currentPosition = ValueNotifier(0);

  /// 当前歌词索引
  ValueNotifier<int> currentLyricIndex = ValueNotifier(-1);

  /// 是否编辑模式
  ValueNotifier<bool> isEditMode = ValueNotifier(false);

  /// 构造函数
  LyricsProvider(LyricsServiceImpl super.lyricsService, this._syncedLyricsService);

  /// 更新播放位置
  void updatePosition(int position) {
    currentPosition.value = position;

    // 如果有同步歌词，更新当前歌词索引
    if (currentLyrics.value != null &&
        currentLyrics.value!.isSynced &&
        showSyncedLyrics.value) {
      final index = _syncedLyricsService.getCurrentLyricIndex(
          currentLyrics.value!, position);
      if (index != currentLyricIndex.value) {
        currentLyricIndex.value = index;
      }
    }
  }

  /// 获取下一行歌词的时间戳
  int getNextLyricTimestamp() {
    if (currentLyrics.value == null ||
        !currentLyrics.value!.isSynced ||
        currentLyricIndex.value < 0) {
      return -1;
    }

    return _syncedLyricsService.getNextLyricTimestamp(
        currentLyrics.value!, currentLyricIndex.value);
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, int newTimestamp) async {
    if (currentLyrics.value == null || !currentLyrics.value!.isSynced) return;

    final updatedLyrics = await _syncedLyricsService.adjustSyncedLyrics(
        currentLyrics.value!, index, newTimestamp);

    if (updatedLyrics != null) {
      currentLyrics.value = updatedLyrics;
    }
  }

  /// 导出LRC格式歌词
  String exportToLRC() {
    if (currentLyrics.value == null || !currentLyrics.value!.isSynced) {
      return '';
    }

    return _syncedLyricsService.exportToLRC(currentLyrics.value!);
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
    final lyrics = await _syncedLyricsService.importFromLRC(lrcContent, track);
    if (lyrics != null) {
      currentLyrics.value = lyrics;
      return true;
    }
    return false;
  }

  /// 切换编辑模式
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  @override
  void dispose() {
    currentPosition.dispose();
    currentLyricIndex.dispose();
    isEditMode.dispose();
    super.dispose();
  }
}
