import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 悬浮歌词状态结构
class FloatingLyricsState {
  final bool isEnabled;
  final String currentLyricText;
  final String currentTranslation;

  const FloatingLyricsState({
    this.isEnabled = false,
    this.currentLyricText = '',
    this.currentTranslation = '',
  });

  FloatingLyricsState copyWith({
    bool? isEnabled,
    String? currentLyricText,
    String? currentTranslation,
  }) {
    return FloatingLyricsState(
      isEnabled: isEnabled ?? this.isEnabled,
      currentLyricText: currentLyricText ?? this.currentLyricText,
      currentTranslation: currentTranslation ?? this.currentTranslation,
    );
  }
}

/// 系统/桌面悬浮歌词服务 (Floating Lyrics Window Service - Riverpod 3.0)
class FloatingLyricsNotifier extends Notifier<FloatingLyricsState> {
  @override
  FloatingLyricsState build() {
    return const FloatingLyricsState();
  }

  void toggleFloatingLyrics() {
    state = state.copyWith(isEnabled: !state.isEnabled);
  }

  void setEnabled(bool enabled) {
    if (state.isEnabled != enabled) {
      state = state.copyWith(isEnabled: enabled);
    }
  }

  void updateLyric(String text, {String translation = ''}) {
    if (state.currentLyricText != text || state.currentTranslation != translation) {
      state = state.copyWith(
        currentLyricText: text,
        currentTranslation: translation,
      );
    }
  }
}

final floatingLyricsServiceProvider = NotifierProvider<FloatingLyricsNotifier, FloatingLyricsState>(() {
  return FloatingLyricsNotifier();
});
