import 'dart:async';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/services/service_registry.dart';

/// 睡眠定时器服务
class SleepTimerService extends BaseService {
  Timer? _timer;
  Duration? _remainingTime;
  bool _finishLastTrack = false;
  
  final _remainingTimeController = StreamController<Duration?>.broadcast();
  
  Stream<Duration?> get remainingTimeStream => _remainingTimeController.stream;
  Duration? get remainingTime => _remainingTime;
  bool get finishLastTrack => _finishLastTrack;

  @override
  String get serviceId => 'sleep_timer';

  @override
  String get serviceName => 'Sleep Timer';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 开启定时器
  void start(Duration duration, {bool finishLastTrack = false}) {
    stop();
    _finishLastTrack = finishLastTrack;
    _remainingTime = duration;
    _remainingTimeController.add(_remainingTime);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == null) {
        timer.cancel();
        return;
      }

      if (_remainingTime!.inSeconds <= 0) {
        _onTimeUp();
        timer.cancel();
      } else {
        _remainingTime = _remainingTime! - const Duration(seconds: 1);
        _remainingTimeController.add(_remainingTime);
      }
    });
  }

  /// 停止定时器
  void stop() {
    _timer?.cancel();
    _timer = null;
    _remainingTime = null;
    _finishLastTrack = false;
    _remainingTimeController.add(null);
  }

  void _onTimeUp() async {
    final registry = ServiceRegistry();
    final playerService = registry.getService<PlayerService>('player_service');
    
    if (playerService == null) return;

    if (_finishLastTrack) {
      // 监听播放完成
      // 这里简化处理，实际可能需要监听 playerService 的状态流
      // 目前先直接暂停
      await playerService.pause();
    } else {
      await playerService.pause();
    }
    
    stop();
  }

  @override
  Future<void> dispose() async {
    stop();
    await _remainingTimeController.close();
    await super.dispose();
  }
}
