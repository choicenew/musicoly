import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/database/isar/entities/index.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/album_model.dart';
import 'package:pyro_music/features/album/presentation/widgets/album_header.dart';
import 'package:pyro_music/features/album/presentation/widgets/album_tracks.dart';
import 'package:pyro_music/features/album/presentation/widgets/album_info.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// 专辑详情页面
class AlbumPage extends StatefulWidget {
  /// 专辑ID
  final String albumId;

  const AlbumPage({
    super.key,
    required this.albumId,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final _isar = GetIt.instance<Isar>();
  List<TrackModel> _tracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbumTracks();
  }

  Future<void> _loadAlbumTracks() async {
    setState(() => _isLoading = true);
    
    final tracks = await _isar.trackEntitys
        .filter()
        .albumIdEqualTo(widget.albumId)
        .findAll();

    setState(() {
      _tracks = tracks.map((e) => TrackModel(
        id: e.trackId,
        platform: e.platform,
        name: e.name,
        artistIds: e.artistIds ?? [],
        artistNames: e.artistNames ?? [],
        imageUrl: e.imageUrl,
        albumId: e.albumId,
        albumName: e.albumName,
        durationMs: e.durationMs,
        localPath: e.localPath,
      )).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_tracks.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.no_tracks_available)),
      );
    }

    final albumName = _tracks.first.albumName ?? l10n.album;
    final artistName = _tracks.first.artistNames.join(', ');
    final imageUrl = _tracks.first.imageUrl;

    final albumModel = AlbumModel(
      id: widget.albumId,
      platform: _tracks.first.platform,
      name: albumName,
      artistIds: _tracks.first.artistIds,
      artistNames: [artistName],
      imageUrl: imageUrl,
      totalTracks: _tracks.length,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 头部 App Bar
          SliverToBoxAdapter(
            child: AlbumHeader(
              album: albumModel,
              tracks: _tracks,
            ),
          ),

          // 专辑信息区域
          SliverToBoxAdapter(
            child: AlbumInfo(
              album: albumModel,
            ),
          ),

          // 歌曲列表区域
          AlbumTracks(tracks: _tracks),
        ],
      ),
    );
  }
}
