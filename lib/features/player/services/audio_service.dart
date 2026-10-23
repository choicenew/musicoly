import 'package:pyro_music/core/services/base_service.dart';

abstract class AudioService extends BaseService {
  String get currentQuality;
  Stream<bool> get volumeNormalizationStream;
  Stream<bool> get skipSilenceStream;
  Stream<Duration> get crossfadeDurationStream;
  Future<void> applyCrossfadeEffect(Duration duration);
}
