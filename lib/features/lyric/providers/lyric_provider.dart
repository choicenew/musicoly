import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/core/models/track_interface.dart';
import 'package:pyro_music/features/lyric/services/lyric_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';

part 'lyric_provider.freezed.dart';
part 'lyric_provider.g.dart';

@freezed
abstract class LyricState with _$LyricState {
  const factory LyricState({
    LyricData? currentLyrics,
    @Default(true) bool showSyncedLyrics,
    @Default(Duration.zero) Duration currentPosition,
    @Default(-1) int currentLyricIndex,
    @Default(false) bool isEditMode,
    @Default(false) bool isLoading,
    String? error,
  }) = _LyricState;
}

/// 歌词提供者实现
@Riverpod(keepAlive: true)
class LyricNotifier extends _$LyricNotifier {
  late final LyricManager _lyricManager;

  @override
  LyricState build() {
    final registry = ServiceRegistry();
    _lyricManager = registry.getService<LyricManager>('lyric_manager')!;
    return const LyricState();
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
    await loadLyrics(track);
  }

  /// 清空歌词
  void clearLyrics() {
    state = const LyricState();
  }

  /// 调整歌词时间戳
  Future<void> adjustLyricTimestamp(int index, Duration newTimestamp) async {
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
    return '';
  }

  /// 从LRC格式导入同步歌词
  Future<bool> importFromLRC(String lrcContent, TrackInterface track) async {
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
