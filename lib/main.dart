import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';
import 'package:pyro_music/l10n/app_localizations.dart';
import 'package:pyro_music/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: PyroMusicApp()));
}

class PyroMusicApp extends ConsumerWidget {
  const PyroMusicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);

    return prefsAsync.when(
      data: (prefs) {
        return MaterialApp.router(
          title: 'Pyro Music',
          themeMode: prefs.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: prefs.accentColor,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: prefs.accentColor,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: prefs.amoledDark ? Colors.black : null,
          ),
          supportedLocales: L10n.all,
          locale: prefs.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: GoRouter(routes: []), // Placeholder router
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
