import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 系统/桌面悬浮歌词服务 (Floating Lyrics Window Service)
class FloatingLyricsService extends ChangeNotifier {
  bool _isEnabled = false;
  String _currentLyricText = '';
  String _currentTranslation = '';

  bool get isEnabled => _isEnabled;
  String get currentLyricText => _currentLyricText;
  String get currentTranslation => _currentTranslation;

  void toggleFloatingLyrics() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  void setEnabled(bool enabled) {
    if (_isEnabled != enabled) {
      _isEnabled = enabled;
      notifyListeners();
    }
  }

  void updateLyric(String text, {String translation = ''}) {
    if (_currentLyricText != text || _currentTranslation != translation) {
      _currentLyricText = text;
      _currentTranslation = translation;
      if (_isEnabled) {
        notifyListeners();
      }
    }
  }
}

final floatingLyricsServiceProvider = ChangeNotifierProvider<FloatingLyricsService>((ref) {
  return FloatingLyricsService();
});
