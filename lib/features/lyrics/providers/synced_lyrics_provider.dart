import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/features/lyrics/providers/lyrics_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyrics/lyrics_interface.dart';

part 'synced_lyrics_provider.freezed.dart';
part 'synced_lyrics_provider.g.dart';

@freezed
abstract class SyncedLyricsState with _$SyncedLyricsState {
  const factory SyncedLyricsState({
    @Default(true) bool autoScroll,
    @Default(true) bool highlightCurrentLine,
    @Default(false) bool showTranslation,
    @Default(16.0) double fontSize,
    @Default(1.5) double lineSpacing,
  }) = _SyncedLyricsState;
}

@Riverpod(keepAlive: true)
class SyncedLyricsNotifier extends _$SyncedLyricsNotifier {
  @override
  SyncedLyricsState build() {
    return const SyncedLyricsState();
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

  // Helper methods that depend on LyricsProvider state
  // These should probably be extension methods or used via ref in UI/Controller
  
  String? getLyricText(int index) {
    final lyricsState = ref.read(lyricsProvider);
    final currentLyrics = lyricsState.currentLyrics;
    
    if (currentLyrics == null ||
        !currentLyrics.isSynced ||
        index < 0 ||
        index >= currentLyrics.syncedLyrics.length) {
      return null;
    }

    return currentLyrics.syncedLyrics[index][1] as String?;
  }

  int? getLyricTimestamp(int index) {
    final lyricsState = ref.read(lyricsProvider);
    final currentLyrics = lyricsState.currentLyrics;

    if (currentLyrics == null ||
        !currentLyrics.isSynced ||
        index < 0 ||
        index >= currentLyrics.syncedLyrics.length) {
      return null;
    }

    return currentLyrics.syncedLyrics[index][0] as int?;
  }

  String formatTimestamp(int timestamp) {
    final minutes = (timestamp ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((timestamp % 60000) ~/ 1000).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
