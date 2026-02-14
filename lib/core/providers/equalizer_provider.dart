import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/services/equalizer_service.dart';

part 'equalizer_provider.g.dart';

@riverpod
class EqualizerNotifier extends _$EqualizerNotifier {
  late final EqualizerService _service;

  @override
  EqualizerState build() {
    final registry = ServiceRegistry();
    _service = registry.getService<EqualizerService>('equalizer_service')!;
    return EqualizerState(
      isEnabled: _service.isEnabled,
      bandLevels: _service.bandLevels,
    );
  }

  Future<void> setEnabled(bool enabled) async {
    await _service.setEnabled(enabled);
    state = state.copyWith(isEnabled: enabled);
  }

  Future<void> setBandLevel(int band, double level) async {
    await _service.setBandLevel(band, level);
    final newLevels = List<double>.from(state.bandLevels);
    newLevels[band] = level;
    state = state.copyWith(bandLevels: newLevels);
  }
}

class EqualizerState {
  final bool isEnabled;
  final List<double> bandLevels;

  EqualizerState({required this.isEnabled, required this.bandLevels});

  EqualizerState copyWith({bool? isEnabled, List<double>? bandLevels}) {
    return EqualizerState(
      isEnabled: isEnabled ?? this.isEnabled,
      bandLevels: bandLevels ?? this.bandLevels,
    );
  }
}
