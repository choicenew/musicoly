import 'package:meta/meta.dart';

@immutable
class EqualizerConfigEntity {
  final bool enabled;
  final List<double> bandGains;

  const EqualizerConfigEntity({
    this.enabled = false,
    this.bandGains = const [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
  });
}
