import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/presentation/widgets/common/track_tile.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/features/local_music/providers/local_scanner_provider.dart';
import 'package:pyro_music/features/local_music/providers/multi_select_provider.dart';
import 'package:pyro_music/presentation/widgets/common/selection_action_bar.dart';

import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/features/player/services/player_service_impl.dart';
import 'package:pyro_music/core/services/local_scanner_service.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';

import 'package:pyro_music/features/player/providers/playback_provider.dart';

class LocalMusicPage extends ConsumerStatefulWidget {
  const LocalMusicPage({super.key});

  @override
  ConsumerState<LocalMusicPage> createState() => _LocalMusicPageState();

  // Method for TrackTile and other widgets to show playlist selection
  static Future<String?> showPlaylistSelectionDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final playlistService = ref.read(playlistServiceProvider);
    final playlists = await playlistService.getUserPlaylists();

    if (!context.mounted) return null;

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.only(top: 24, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.add_to_playlist,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (playlists.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(l10n.no_playlists),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      leading: const Icon(Icons.playlist_add),
                      title: Text(playlist.name),
                      subtitle: Text(l10n.track_count(playlist.totalTracks)),
                      onTap: () => Navigator.pop(context, playlist.id),
                    );
                  },
                ),
              ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(l10n.create_playlist),
              onTap: () async {
                final newName = await showCreatePlaylistDialog(context);
                if (newName != null && context.mounted) {
                  final newPlaylist = await playlistService.createPlaylist(name: newName);
                  if (newPlaylist != null && context.mounted) {
                    Navigator.pop(context, newPlaylist.id);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(l10n.cancel),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String?> showCreatePlaylistDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.create_playlist,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.playlist_name,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: Text(l10n.create),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocalMusicPageState extends ConsumerState<LocalMusicPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<TrackEntity> _tracks = [];
  bool _isLoading = true;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadTracks();
    _subscribeToChanges();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    // 过滤出本地轨道 (localPath 不为空)
    final tracks = await isar.trackEntitys
        .filter()
        .localPathIsNotNull()
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
    final isScanning = ref.watch(localScannerProvider);
    final selectedIds = ref.watch(multiSelectProvider);
    final isSelectionMode = selectedIds.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.local_music),
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
            )
          else ...[
            IconButton(
              icon: isScanning 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.refresh),
              onPressed: isScanning ? null : () async {
                await ref.read(localScannerProvider.notifier).scan();
                await _loadTracks();
              },
            ),
          ],
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.all_tracks),
            Tab(text: l10n.recently_added),
            Tab(text: l10n.recently_played),
            Tab(text: l10n.most_played),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildTrackList(_tracks),
                _buildSmartTrackList('recently_added'),
                _buildSmartTrackList('recently_played'),
                _buildSmartTrackList('most_played'),
              ],
            ),
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
        onDelete: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n.delete),
              content: Text(l10n.confirm_delete_tracks(selectedIds.length)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );

          if (confirm == true) {
            final scannerService = ServiceRegistry().getService<LocalScannerService>('local_scanner');
            if (scannerService != null) {
              await scannerService.deleteTracks(selectedIds.toList());
              ref.read(multiSelectProvider.notifier).clear();
              await _loadTracks();
            }
          }
        },
      ),
    );
  }

  Widget _buildTrackList(List<TrackEntity> tracks) {
    if (tracks.isEmpty) {
      final l10n = AppLocalizations.of(context);
      final isScanning = ref.watch(localScannerProvider);
      return _buildEmptyState(l10n, isScanning);
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
      platform: 'local',
      name: entity.name,
      artistIds: const [],
      artistNames: entity.artistNames ?? const [],
      albumName: entity.albumName,
      durationMs: entity.durationMs,
      imageUrl: entity.imageUrl,
      previewUrl: entity.localPath != null ? 'file://${entity.localPath}' : null,
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

  Widget _buildSmartTrackList(String type) {
    return FutureBuilder<List<TrackInterface>>(
      future: ref.read(playlistServiceProvider).getSmartPlaylistTracks(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final tracks = snapshot.data ?? [];
        if (tracks.isEmpty) {
          return const Center(child: Text('No tracks found'));
        }

        return ListView.builder(
          itemCount: tracks.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildPlayHeader(tracks.map((t) => t.id).toList());
            }
            final track = tracks[index - 1] as TrackModel;
            return TrackTile(
              track: track,
              onTap: () {
                ref.read(playbackStateProvider.notifier).playTracks(
                  tracks.map((t) => t.id).toList(),
                  initialIndex: index - 1,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, bool isScanning) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_music_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(l10n.no_tracks_available),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: isScanning 
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.search),
            label: Text(isScanning ? l10n.scanning : l10n.scan_local_music),
            onPressed: isScanning ? null : () async {
              await ref.read(localScannerProvider.notifier).scan();
              await _loadTracks();
            },
          ),
        ],
      ),
    );
  }
}
