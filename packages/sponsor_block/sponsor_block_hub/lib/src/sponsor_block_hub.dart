import 'package:sponsor_block_driver/sponsor_block_driver.dart';
import 'package:sponsor_block_protocol/sponsor_block_protocol.dart';

class SponsorBlockHub {
  final SponsorBlockApiDriver _driver = SponsorBlockApiDriver();
  bool _enabled = true;

  bool get enabled => _enabled;

  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  Future<List<SponsorSegmentEntity>> fetchSegments(String videoId) async {
    if (!_enabled) return [];
    return _driver.getSegments(videoId);
  }
}
