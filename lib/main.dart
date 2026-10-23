import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/features/theme/providers/dynamic_theme_provider.dart';
import 'package:pyro_music/core/router/router.dart';
import 'package:pyro_music/core/database/isar/entities/index.dart';
import 'package:pyro_music/core/init/service_initializer.dart';
import 'package:pyro_music/core/services/pyro_audio_handler.dart';
import 'package:pyro_music/presentation/widgets/keyboard_shortcuts_handler.dart';
import 'package:pyro_music/core/services/scrobbler_manager.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:audio_service/audio_service.dart' hide PlaybackState;
import 'package:app_links/app_links.dart';

late AudioHandler audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化数据库
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      TrackEntitySchema,
      PlaylistEntitySchema,
      LyricsEntitySchema,
    ],
    directory: dir.path,
  );

  // 初始化核心服务
  await ServiceInitializer.initialize(isar);

  // 处理深层链接
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((uri) {
    final scrobblerManager = ServiceRegistry().getService<ScrobblerManager>('scrobbler_manager');
    scrobblerManager?.handleDeepLink(uri);
  });

  // 初始化 AudioService
  audioHandler = await AudioService.init(
    builder: () => PyroAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.pyromusic.app.channel.audio',
      androidNotificationChannelName: 'Pyro Music Playback',
      androidNotificationOngoing: true,
    ),
  );

  runApp(const ProviderScope(child: PyroMusicApp()));
}

/// 自定义滚动行为，全局启用弹性滚动
class BouncyScrollBehavior extends MaterialScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}

class PyroMusicApp extends ConsumerWidget {
  const PyroMusicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final dynamicColor = ref.watch(dynamicThemeProvider);

    return prefsAsync.when(
      data: (prefs) {
        final seedColor = dynamicColor ?? prefs.accentColor;

        return MaterialApp.router(
          title: 'Pyro Music',
          scrollBehavior: BouncyScrollBehavior(),
          themeMode: prefs.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: seedColor,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: seedColor,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: prefs.amoledDark ? Colors.black : null,
          ),
          supportedLocales: AppLocalizations.supportedLocales,
          locale: prefs.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: router,
          builder: (context, child) {
            return KeyboardShortcutsHandler(child: child!);
          },
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, st) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
