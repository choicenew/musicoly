import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/playlist_model.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_header.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_tracks_list.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_info.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';

/// 歌单详情页面
class PlaylistPage extends ConsumerStatefulWidget {
  /// 歌单ID
  final String playlistId;

  const PlaylistPage({
    super.key,
    required this.playlistId,
  });

  @override
  ConsumerState<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(playlistProvider.notifier).loadPlaylist(widget.playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playlistProvider);
    final playlist = state.selectedPlaylist;
    final tracks = state.playlistTracks ?? [];

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (playlist == null) {
      return const Scaffold(
        body: Center(child: Text('Playlist not found')),
      );
    }

    final playlistModel = playlist is PlaylistModel
        ? playlist
        : PlaylistModel(
            id: playlist.id,
            platform: playlist.platform,
            name: playlist.name,
            description: playlist.description,
            imageUrl: playlist.imageUrl,
            totalTracks: tracks.length,
          );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PlaylistHeader(playlist: playlistModel),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PlaylistInfo(playlist: playlistModel),
            ),
          ),
          SliverToBoxAdapter(
            child: PlaylistTracksList(
              playlistId: widget.playlistId,
              tracks: tracks,
            ),
          ),
        ],
      ),
    );
  }
}
