import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';
import 'package:pyro_music/features/lyric/providers/lyric_provider.dart';
import 'package:pyro_music/features/lyric/providers/synced_lyric_provider.dart';

export 'package:pyro_music/core/models/lyric_data_model.dart';

/// Controller for lyric functionality
class LyricController {
  final Ref _ref;

  LyricController(this._ref);

  ValueNotifier<LyricData?> get currentLyrics => ValueNotifier(_ref.watch(lyricProvider).currentLyrics);
  ValueNotifier<bool> get showSyncedLyrics => ValueNotifier(_ref.watch(lyricProvider).showSyncedLyrics);
  ValueNotifier<Duration> get currentPosition => ValueNotifier(_ref.watch(lyricProvider).currentPosition);
  ValueNotifier<int> get currentLyricIndex => ValueNotifier(_ref.watch(lyricProvider).currentLyricIndex);
  ValueNotifier<bool> get isEditMode => ValueNotifier(_ref.watch(lyricProvider).isEditMode);

  ValueNotifier<bool> get autoScroll => ValueNotifier(_ref.watch(syncedLyricProvider).autoScroll);
  ValueNotifier<bool> get highlightCurrentLine => ValueNotifier(_ref.watch(syncedLyricProvider).highlightCurrentLine);
  ValueNotifier<bool> get showTranslation => ValueNotifier(_ref.watch(syncedLyricProvider).showTranslation);
  ValueNotifier<double> get fontSize => ValueNotifier(_ref.watch(syncedLyricProvider).fontSize);
  ValueNotifier<double> get lineSpacing => ValueNotifier(_ref.watch(syncedLyricProvider).lineSpacing);

  void clearLyrics() {
    _ref.read(lyricProvider.notifier).clearLyrics();
  }

  void updatePosition(Duration position) {
    _ref.read(lyricProvider.notifier).updatePosition(position);
  }

  Future<void> loadSyncedLyrics(dynamic track) async {
    await _ref.read(lyricProvider.notifier).loadSyncedLyrics(track);
  }

  Future<void> loadLyrics(dynamic track) async {
    await _ref.read(lyricProvider.notifier).loadLyrics(track);
  }

  void toggleSyncedLyrics() {
    _ref.read(lyricProvider.notifier).toggleSyncedLyrics();
  }

  void toggleAutoScroll() {
    _ref.read(syncedLyricProvider.notifier).toggleAutoScroll();
  }

  void toggleHighlightCurrentLine() {
    _ref.read(syncedLyricProvider.notifier).toggleHighlightCurrentLine();
  }

  void toggleShowTranslation() {
    _ref.read(syncedLyricProvider.notifier).toggleShowTranslation();
  }

  void toggleEditMode() {
    _ref.read(lyricProvider.notifier).toggleEditMode();
  }

  void setFontSize(double size) {
    _ref.read(syncedLyricProvider.notifier).setFontSize(size);
  }

  void setLineSpacing(double spacing) {
    _ref.read(syncedLyricProvider.notifier).setLineSpacing(spacing);
  }

  Future<void> adjustLyricTimestamp(int index, Duration newTimestamp) async {
    await _ref.read(lyricProvider.notifier).adjustLyricTimestamp(index, newTimestamp);
  }

  String exportToLRC() {
    return _ref.read(lyricProvider.notifier).exportToLRC();
  }

  Future<bool> importFromLRC(String lrcContent, dynamic track) async {
    return await _ref.read(lyricProvider.notifier).importFromLRC(lrcContent, track);
  }

  Future<List<LyricData>> searchLyrics(String query, {int limit = 10, int offset = 0}) async {
    return await _ref.read(lyricProvider.notifier).searchLyrics(query, limit: limit, offset: offset);
  }

  Future<bool> saveLyrics(LyricData lyrics) async {
    return await _ref.read(lyricProvider.notifier).saveLyrics(lyrics);
  }

  static final provider = Provider.autoDispose<LyricController>((ref) {
    return LyricController(ref);
  });
}
