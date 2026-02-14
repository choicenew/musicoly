import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/storage/isar/entities/track_entity.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/providers/multi_select_provider.dart';
import 'package:pyro_music/presentation/widgets/common/selection_action_bar.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';
import 'package:pyro_music/presentation/pages/local_music/local_music_page.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  List<TrackEntity> _tracks = [];
  bool _isLoading = true;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _loadTracks();
    _subscribeToChanges();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _subscribeToChanges() {
    final isar = GetIt.instance<Isar>();
    _subscription = isar.trackEntitys.watchLazy().listen((_) {
      _loadTracks();
    });
  }

  Future<void> _loadTracks() async {
    final isar = GetIt.instance<Isar>();
    final tracks = await isar.trackEntitys
        .where()
        .isFavoriteEqualTo(true)
        .findAll();
    
    if (mounted) {
      setState(() {
        _tracks = tracks;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedIds = ref.watch(multiSelectProvider);
    final isSelectionMode = selectedIds.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
        leading: isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => ref.read(multiSelectProvider.notifier).clear(),
              )
            : null,
        actions: [
          if (isSelectionMode)
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: () {
                final allIds = _tracks.map((t) => t.trackId).toList();
                ref.read(multiSelectProvider.notifier).selectAll(allIds);
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildTrackList(_tracks),
      bottomNavigationBar: SelectionActionBar(
        allIds: _tracks.map((t) => t.trackId).toList(),
        onPlayNext: () async {
          final playerService = ServiceRegistry().getService<PlayerService>('player_service');
          if (playerService != null) {
            await playerService.addTracksNext(selectedIds.toList());
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.added_to_queue(selectedIds.length))),
              );
              ref.read(multiSelectProvider.notifier).clear();
            }
          }
        },
        onAddToPlaylist: () async {
          final playlistId = await LocalMusicPage.showPlaylistSelectionDialog(context, ref);
          if (playlistId != null) {
            final success = await ref.read(playlistServiceProvider).addTracksToPlaylist(
              playlistId: playlistId,
              trackIds: selectedIds.toList(),
            );
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.added_to_playlist)),
              );
              ref.read(multiSelectProvider.notifier).clear();
            }
          }
        },
        onDelete: null, // Don't allow delete from disk in favorites page, just remove from favorites
      ),
    );
  }

  Widget _buildTrackList(List<TrackEntity> tracks) {
    if (tracks.isEmpty) {
      final l10n = AppLocalizations.of(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(l10n.no_tracks_available),
          ],
        ),
      );
    }

    final trackIds = tracks.map((t) => t.trackId).toList();

    return ListView.builder(
      itemCount: tracks.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildPlayHeader(trackIds);
        }
        final entity = tracks[index - 1];
        return _buildTrackTile(entity, trackIds, index - 1);
      },
    );
  }

  Widget _buildPlayHeader(List<String> trackIds) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                ref.read(playbackStateProvider.notifier).playTracks(trackIds, initialIndex: 0);
              },
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n.play_all),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                final shuffledIds = List<String>.from(trackIds)..shuffle();
                ref.read(playbackStateProvider.notifier).playTracks(shuffledIds, initialIndex: 0);
              },
              icon: const Icon(Icons.shuffle),
              label: Text(l10n.shuffle_all),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackTile(TrackEntity entity, List<String> playlistTrackIds, int index) {
    final track = TrackModel(
      id: entity.trackId,
      platform: entity.platform,
      name: entity.name,
      artistIds: entity.artistIds ?? const [],
      artistNames: entity.artistNames ?? const [],
      albumName: entity.albumName,
      durationMs: entity.durationMs,
      imageUrl: entity.imageUrl,
      previewUrl: entity.localPath != null ? 'file://${entity.localPath}' : entity.previewUrl,
      localPath: entity.localPath,
      isFavorite: entity.isFavorite,
    );
    return TrackTile(
      track: track,
      onTap: () {
        ref.read(playbackStateProvider.notifier).playTracks(playlistTrackIds, initialIndex: index);
      },
    );
  }
}
