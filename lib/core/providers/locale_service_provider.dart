import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/features/language/services/locale_service.dart';
import 'package:config_package/config_package.dart';

part 'locale_service_provider.g.dart';

@riverpod
LocaleService localeService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return LocaleService(configRepository);
}
