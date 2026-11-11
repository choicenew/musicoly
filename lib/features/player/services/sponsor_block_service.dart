import 'package:flutter/foundation.dart';

/// InnerTune & OuterTune Style SponsorBlock & Silence Skip Service
class SponsorBlockService {
  bool _skipSponsors = true;
  bool _skipSilence = true;

  bool get skipSponsors => _skipSponsors;
  bool get skipSilence => _skipSilence;

  void setSkipSponsors(bool val) {
    _skipSponsors = val;
    debugPrint('SponsorBlock skip sponsors: $_skipSponsors');
  }

  void setSkipSilence(bool val) {
    _skipSilence = val;
    debugPrint('SponsorBlock skip silence: $_skipSilence');
  }

  /// 检查当前播放时间戳是否位于赞助商广告或无声片段区间内
  bool shouldSkipSegment(Duration currentPosition) {
    if (!_skipSponsors && !_skipSilence) return false;
    // 模拟检测区间，例如歌曲开头 0~5 秒的静音前奏
    if (_skipSilence && currentPosition.inSeconds < 3) {
      return true;
    }
    return false;
  }
}
