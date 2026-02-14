import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'lyrics_provider.freezed.dart';
part 'lyrics_provider.g.dart';

@freezed
abstract class LyricsState with _$LyricsState {
  const factory LyricsState({
    LyricData? currentLyrics,
    @Default(true) bool showSyncedLyrics,
    @Default(Duration.zero) Duration currentPosition,
    @Default(-1) int currentLyricIndex,
    @Default(false) bool isEditMode,
    @Default(false) bool isLoading,
    String? error,
  }) = _LyricsState;
}

/// 歌词提供者实现
@Riverpod(keepAlive: true)
class LyricsNotifier extends _$LyricsNotifier {
  late final LyricManager _lyricManager;

  @override
  LyricsState build() {
    final registry = ServiceRegistry();
    _lyricManager = registry.getService<LyricManager>('lyric_manager')!;
    return const LyricsState();
  }

  /// 加载歌词
  Future<void> loadLyrics(TrackInterface track) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final lyrics = await _lyricManager.getLyric(track.id, metadata: {
        'title': track.name,
        'artists': track.artistNames,
      });
      state = state.copyWith(currentLyrics: lyrics, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// 更新播放位置
  void updatePosition(Duration position) {
    int newIndex = -1;

    // 如果有歌词，更新当前歌词索引
    if (state.currentLyrics != null && state.currentLyrics!.lines.isNotEmpty) {
      final lines = state.currentLyrics!.lines;
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].startTime <= position) {
          newIndex = i;
        } else {
          break;
        }
      }
    }

    state = state.copyWith(
      currentPosition: position,
      currentLyricIndex: newIndex,
    );
  }

  /// 加载同步歌词
  Future<void> loadSyncedLyrics(TrackInterface track) async {
    // 逻辑类似于 loadLyrics，但可能需要指定特定插件或过滤同步歌词
    await loadLyrics(track);
  }

  /// 清空歌词
  void clearLyrics() {
    state = const LyricsState();
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, int newTimestamp) async {
    // TODO: 实现调整时间戳逻辑
    debugPrint('调整歌词索引 $index 的时间戳为 $newTimestamp');
  }

  /// 搜索歌词
  Future<List<LyricData>> searchLyrics(String query,
      {int limit = 10, int offset = 0}) async {
    try {
      return await _lyricManager.searchLyrics(query,
          limit: limit, offset: offset);
    } catch (e) {
      debugPrint('搜索歌词失败: $e');
      return [];
    }
  }

  /// 保存歌词
  Future<bool> saveLyrics(LyricData lyrics) async {
    try {
      // 获取当前曲目 ID，通常是从 state 或外部传入
      // 这里假设我们需要传入 trackId，或者从 lyrics 元数据中获取
      final trackId = lyrics.metadata['trackId'] as String?;
      if (trackId == null) return false;
      
      return await _lyricManager.saveLyric(trackId, lyrics);
    } catch (e) {
      debugPrint('保存歌词失败: $e');
      return false;
    }
  }

  /// 导出LRC格式歌词
  String exportToLRC() {
    if (state.currentLyrics == null) {
      return '';
    }
    // TODO: 实现 LRC 导出逻辑
    return '';
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
    // TODO: 实现 LRC 导入逻辑
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
}
