import 'package:flutter/material.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_header.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_tracks_list.dart';
import 'package:pyro_music/features/playlist/presentation/widgets/playlist_info.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// 歌单详情页面
class PlaylistPage extends StatelessWidget {
  /// 歌单ID
  final String playlistId;

  const PlaylistPage({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 头部 App Bar
          PlaylistHeader(playlistId: playlistId),

          // 歌单信息区域
          PlaylistInfo(playlistId: playlistId),

          // 歌单歌曲列表
          PlaylistTracksList(playlistId: playlistId),
        ],
      ),
    );
  }
}
