import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/language/services/locale_service.dart';
import 'package:pyro_music/core/services/config_repository.dart';

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return const SharedPreferencesConfigRepository();
});

final localeServiceProvider = Provider<LocaleService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return LocaleService(configRepository);
});
