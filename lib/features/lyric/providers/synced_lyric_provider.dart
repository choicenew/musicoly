import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/features/lyric/providers/lyric_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';

part 'synced_lyric_provider.freezed.dart';
part 'synced_lyric_provider.g.dart';

@freezed
abstract class SyncedLyricState with _$SyncedLyricState {
  const factory SyncedLyricState({
    @Default(true) bool autoScroll,
    @Default(true) bool highlightCurrentLine,
    @Default(false) bool showTranslation,
    @Default(16.0) double fontSize,
    @Default(1.5) double lineSpacing,
  }) = _SyncedLyricState;
}

@Riverpod(keepAlive: true)
class SyncedLyricNotifier extends _$SyncedLyricNotifier {
  @override
  SyncedLyricState build() {
    return const SyncedLyricState();
  }

  void toggleAutoScroll() {
    state = state.copyWith(autoScroll: !state.autoScroll);
  }

  void toggleHighlightCurrentLine() {
    state = state.copyWith(highlightCurrentLine: !state.highlightCurrentLine);
  }

  void toggleShowTranslation() {
    state = state.copyWith(showTranslation: !state.showTranslation);
  }

  void setFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void setLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
  }

  // Helper methods that depend on LyricProvider state
  // These should probably be extension methods or used via ref in UI/Controller
  
  String? getLyricText(int index) {
    final lyricState = ref.read(lyricProvider);
    final currentLyrics = lyricState.currentLyrics;
    
    if (currentLyrics == null ||
        !currentLyrics.isSynced ||
        index < 0 ||
        index >= currentLyrics.lines.length) {
      return null;
    }

    return currentLyrics.lines[index].text;
  }

  int? getLyricTimestamp(int index) {
    final lyricState = ref.read(lyricProvider);
    final currentLyrics = lyricState.currentLyrics;

    if (currentLyrics == null ||
        !currentLyrics.isSynced ||
        index < 0 ||
        index >= currentLyrics.lines.length) {
      return null;
    }

    return currentLyrics.lines[index].startTime.inMilliseconds;
  }

  String formatTimestamp(int timestamp) {
    final minutes = (timestamp ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((timestamp % 60000) ~/ 1000).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
