import 'package:go_router/go_router.dart';
import 'package:pyro_music/features/album/presentation/album_page.dart';
import 'package:pyro_music/features/artist/presentation/artist_page.dart';
import 'package:pyro_music/features/favorites/presentation/favorites_page.dart';
import 'package:pyro_music/features/home/presentation/home_page.dart';
import 'package:pyro_music/features/local_music/presentation/local_music_page.dart';
import 'package:pyro_music/features/lyric/presentation/lyrics_page.dart';
import 'package:pyro_music/features/player/presentation/player_page.dart';
import 'package:pyro_music/features/playlist/presentation/playlist_page.dart';
import 'package:pyro_music/features/search/presentation/search_page.dart';
import 'package:pyro_music/features/settings/presentation/settings_page.dart';
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
              path: 'local-music',
              builder: (context, state) => const LocalMusicPage(),
            ),
            GoRoute(
              path: 'favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
            GoRoute(
              path: 'album/:id',
              builder: (context, state) =>
                  AlbumPage(albumId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: 'artist/:id',
              builder: (context, state) =>
                  ArtistPage(artistId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: 'playlist/:id',
              builder: (context, state) =>
                  PlaylistPage(playlistId: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/lyrics',
      builder: (context, state) => const LyricsPage(),
    ),
    GoRoute(
      path: '/player',
      builder: (context, state) => const PlayerPage(),
    ),
  ],
);
