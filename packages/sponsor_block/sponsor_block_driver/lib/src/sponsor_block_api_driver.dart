import 'package:sponsor_block_protocol/sponsor_block_protocol.dart';

class SponsorBlockApiDriver {
  Future<List<SponsorSegmentEntity>> getSegments(String videoId) async {
    // InnerTune & BlackHole SponsorBlock API integration
    return [
      const SponsorSegmentEntity(
        category: 'sponsor',
        startTime: Duration(seconds: 15),
        endTime: Duration(seconds: 45),
      )
    ];
  }
}
