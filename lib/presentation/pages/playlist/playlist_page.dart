import 'package:flutter/material.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_header.dart';
// 修正为正确的导入路径
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_tracks_list.dart';
import 'package:pyro_music/presentation/pages/playlist/widgets/playlist_info.dart';

/// The playlist details page
class PlaylistPage extends StatelessWidget {
  /// The ID of the playlist to display
  final String playlistId;

  const PlaylistPage({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context) {
    // 实际应从数据层获取播放列表数据
    const playlist = null; 

    return Scaffold(
      body: playlist == null
          ? _buildErrorState(context)
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PlaylistHeader(playlist: playlist),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PlaylistInfo(playlist: playlist),
                  ),
                ),
                // 使用正确的组件名称
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PlaylistTracksList(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.queue_music_outlined,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.playlist_not_found,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.something_went_wrong,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(l10n.previous),
          ),
        ],
      ),
    );
  }
}
