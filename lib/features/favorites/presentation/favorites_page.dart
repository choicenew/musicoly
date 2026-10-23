import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/database/isar/entities/index.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/presentation/widgets/common/selection_action_bar.dart';
import 'package:pyro_music/features/local_music/providers/multi_select_provider.dart';
import 'package:pyro_music/features/local_music/presentation/local_music_page.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';

/// 收藏歌曲页面
class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  final _isar = GetIt.instance<Isar>();
  List<TrackModel> _favoriteTracks = [];
  bool _isLoading = true;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _listenToChanges();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _listenToChanges() {
    _subscription = _isar.trackEntitys.watchLazy().listen((_) {
      _loadFavorites();
    });
  }

  Future<void> _loadFavorites() async {
    final tracks = await _isar.trackEntitys
        .filter()
        .isFavoriteEqualTo(true)
        .findAll();

    if (mounted) {
      setState(() {
        _favoriteTracks = tracks.map((e) => TrackModel(
          id: e.trackId,
          platform: e.platform,
          name: e.name,
          imageUrl: e.imageUrl,
          artistNames: e.artistNames ?? [],
          artistIds: e.artistIds ?? [],
          albumId: e.albumId,
          albumName: e.albumName,
          durationMs: e.durationMs,
          localPath: e.localPath,
          isFavorite: e.isFavorite,
        )).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedItems = ref.watch(multiSelectProvider);
    final isSelectionMode = selectedItems.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode 
          ? l10n.selected_count(selectedItems.length.toString()) 
          : l10n.favorites),
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: () {
                final allIds = _favoriteTracks.map((t) => t.id).toList();
                ref.read(multiSelectProvider.notifier).selectAll(allIds);
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => ref.read(multiSelectProvider.notifier).clear(),
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.play_arrow),
              tooltip: l10n.play_all,
              onPressed: _favoriteTracks.isEmpty ? null : () => _playAll(ref),
            ),
            IconButton(
              icon: const Icon(Icons.shuffle),
              tooltip: l10n.shuffle_play,
              onPressed: _favoriteTracks.isEmpty ? null : () => _shufflePlay(ref),
            ),
          ],
        ],
      ),
      body: _buildBody(l10n),
      bottomNavigationBar: isSelectionMode 
        ? SelectionActionBar(
            selectedTrackIds: selectedItems.toList(),
            onClear: () => ref.read(multiSelectProvider.notifier).clear(),
            onBatchOperationComplete: () => ref.read(multiSelectProvider.notifier).clear(),
          )
        : null,
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_favoriteTracks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.no_favorites,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.no_favorites_hint,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _favoriteTracks.length,
      itemBuilder: (context, index) {
        final track = _favoriteTracks[index];
        return TrackTile(
          track: track,
          onTap: () {
            ref.read(playbackStateProvider.notifier).playTracks(
              _favoriteTracks.map((t) => t.id).toList(),
              initialIndex: index,
            );
          },
        );
      },
    );
  }

  void _playAll(WidgetRef ref) {
    final trackIds = _favoriteTracks.map((t) => t.id).toList();
    ref.read(playbackStateProvider.notifier).playTracks(trackIds, initialIndex: 0);
  }

  void _shufflePlay(WidgetRef ref) {
    final trackIds = _favoriteTracks.map((t) => t.id).toList();
    final shuffledIds = List<String>.from(trackIds)..shuffle();
    ref.read(playbackStateProvider.notifier).playTracks(shuffledIds, initialIndex: 0);
  }
}
