import 'package:metadata_god/metadata_god.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/services/local_scanner_service.dart';

part 'local_scanner_provider.g.dart';

@riverpod
class LocalScannerNotifier extends _$LocalScannerNotifier {
  late final LocalScannerService _service;

  @override
  bool build() {
    final registry = ServiceRegistry();
    _service = registry.getService<LocalScannerService>('local_scanner')!;
    return _service.isScanning;
  }

  Future<void> scan() async {
    if (state) return;
    state = true;
    try {
      await _service.scan();
    } finally {
      state = false;
    }
  }

  Future<void> updateMetadata(String trackId, Metadata metadata) async {
    await _service.updateMetadata(trackId, metadata);
  }
}
