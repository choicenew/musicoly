import 'package:go_router/go_router.dart';
import 'package:pyro_music/presentation/pages/home/home_page.dart';
import 'package:pyro_music/presentation/pages/search/search_page.dart';
import 'package:pyro_music/presentation/pages/settings/settings_page.dart';
import 'package:pyro_music/presentation/pages/lyrics/lyrics_page.dart';
import 'package:pyro_music/presentation/pages/album/album_page.dart';
import 'package:pyro_music/presentation/pages/artist/artist_page.dart';
import 'package:pyro_music/presentation/pages/playlist/playlist_page.dart';
import 'package:pyro_music/presentation/widgets/layout/main_layout.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'search',
              builder: (context, state) => const SearchPage(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
            GoRoute(
              path: 'album/:id',
              builder: (context, state) => AlbumPage(albumId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: 'artist/:id',
              builder: (context, state) => ArtistPage(artistId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: 'playlist/:id',
              builder: (context, state) => PlaylistPage(playlistId: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
    ),
    // 歌词页通常是全屏的，不包含在 MainLayout 中
    GoRoute(
      path: '/lyrics',
      builder: (context, state) => const LyricsPage(),
    ),
  ],
);
