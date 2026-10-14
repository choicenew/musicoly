import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_music/features/playlist/providers/playlist_provider.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/features/player/providers/playback_provider.dart';
import 'package:pyro_music/core/base/interfaces/player/playback_interface.dart';
import 'package:pyro_music/presentation/widgets/player/player_controls.dart';
import 'package:pyro_music/presentation/pages/player/widgets/player_progress_bar.dart';
import 'package:pyro_music/presentation/pages/player/widgets/player_artwork.dart';
import 'package:pyro_music/presentation/pages/player/widgets/player_header.dart';
import 'package:pyro_music/presentation/pages/player/widgets/player_queue_sheet.dart';
import 'package:pyro_music/presentation/pages/settings/widgets/equalizer_settings.dart';
import 'package:pyro_music/core/providers/sleep_timer_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/synced_lyrics_widget.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/plain_lyrics_widget.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/core/base/interfaces/media/playlist_interface.dart';
import 'package:pyro_music/core/base/services/playlist_service.dart';

/// 全屏播放器页面
class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({super.key});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  bool _showLyrics = false;

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerStateProvider);
    final playbackState = ref.watch(playbackStateProvider);
    final track = playerState.currentTrack;
    final l10n = AppLocalizations.of(context);
    
    if (track == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.no_track_playing)),
      );
    }

    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. 背景模糊效果
          _buildBackground(track.imageUrl),
          
          // 2. 主内容布局
          SafeArea(
            child: Column(
              children: [
                // 顶部标题和返回按钮
                PlayerHeader(
                  title: track.name,
                  artist: track.artistNames.join(', '),
                  onClose: () => context.pop(),
                ),
                
                const Spacer(),
                
                // 中间区域：封面或歌词
                Expanded(
                  flex: 10,
                  child: AnimatedCrossFade(
                    firstChild: PlayerArtwork(
                      imageUrl: track.imageUrl,
                      onTap: () => setState(() => _showLyrics = true),
                    ),
                    secondChild: GestureDetector(
                      onTap: () => setState(() => _showLyrics = false),
                      child: _buildLyricsView(),
                    ),
                    crossFadeState: _showLyrics 
                        ? CrossFadeState.showSecond 
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
                
                const Spacer(),
                
                // 底部区域：进度条、控制按钮
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              track.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: track.isFavorite ? Colors.red : null,
                            ),
                            onPressed: () async {
                              final success = await ref.read(playlistServiceProvider).toggleFavorite(track.id);
                              if (success) {
                                // 刷新当前曲目状态以更新 UI
                                ref.read(playerStateProvider.notifier).refreshCurrentTrack();
                              }
                            },
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  track.name,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  track.artistNames.join(', '),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.textTheme.bodySmall?.color,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => _showMoreOptions(context, track, ref),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // 进度条
                      const PlayerProgressBar(),
                      
                      const SizedBox(height: 24),
                      
                      // 播放控制
                      PlayerControls(
                        isPlaying: playbackState.playbackState == PlaybackState.playing,
                        isShuffleEnabled: playbackState.shuffleMode,
                        repeatMode: playbackState.repeatMode,
                        onPlayPause: () {
                          if (playbackState.playbackState == PlaybackState.playing) {
                            ref.read(playbackStateProvider.notifier).pause();
                          } else {
                            ref.read(playbackStateProvider.notifier).resume();
                          }
                        },
                        onNext: () => ref.read(playbackStateProvider.notifier).next(),
                        onPrevious: () => ref.read(playbackStateProvider.notifier).previous(),
                        onShuffle: () => ref.read(playbackStateProvider.notifier).toggleShuffle(),
                        onRepeat: () => ref.read(playbackStateProvider.notifier).toggleRepeatMode(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // 底部功能按钮 (歌词、定时器、均衡器等)
                      _buildBottomActions(context, l10n),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context, TrackInterface track, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.equalizer),
                title: Text(l10n.equalizer),
                onTap: () {
                  Navigator.pop(context);
                  _showEqualizer(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer),
                title: Text(l10n.sleep_timer),
                subtitle: ref.watch(sleepTimerProvider) != null
                    ? Text(l10n.minutes_remaining(ref.watch(sleepTimerProvider)!.inMinutes.toString()))
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  _showSleepTimerDialog(context, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: Text(l10n.add_to_playlist),
                onTap: () {
                  Navigator.pop(context);
                  _showPlaylistPicker(context, track, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.album),
                title: Text(l10n.go_to_album),
                onTap: () {
                  Navigator.pop(context);
                  if (track.albumId != null) {
                    context.push('/album/${track.albumId}');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(l10n.go_to_artist),
                onTap: () {
                  Navigator.pop(context);
                  if (track.artistIds.length > 1) {
                    _showArtistPicker(context, track);
                  } else if (track.artistIds.isNotEmpty) {
                    context.push('/artist/${track.artistIds.first}');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.track_details),
                onTap: () {
                  Navigator.pop(context);
                  _showTrackDetails(context, track);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEqualizer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: EqualizerSettings(),
      ),
    );
  }

  void _showSleepTimerDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final minutes = [10, 15, 30, 45, 60, 90];
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  l10n.sleep_timer,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...minutes.map((m) => ListTile(
                title: Text('$m ${l10n.minutes}'),
                onTap: () {
                  ref.read(sleepTimerProvider.notifier).start(Duration(minutes: m));
                  Navigator.pop(context);
                },
              )),
              ListTile(
                title: Text(l10n.cancel_timer),
                textColor: Colors.red,
                onTap: () {
                  ref.read(sleepTimerProvider.notifier).stop();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlaylistPicker(BuildContext context, TrackInterface track, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final playlistService = ref.read(playlistServiceProvider);
    
    // Show a loading indicator while fetching playlists
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder<List<PlaylistInterface>>(
          future: playlistService.getUserPlaylists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (snapshot.hasError) {
              return SizedBox(
                height: 200,
                child: Center(child: Text('Error: ${snapshot.error}')),
              );
            }
            
            final playlists = snapshot.data ?? [];
            if (playlists.isEmpty) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(l10n.no_results_found('Playlists'))),
              );
            }
            
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      l10n.add_to_playlist,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        final playlist = playlists[index];
                        return ListTile(
                          leading: const Icon(Icons.playlist_play),
                          title: Text(playlist.name),
                          onTap: () async {
                            final success = await playlistService.addTracksToPlaylist(
                              playlistId: playlist.id, 
                              trackIds: [track.id],
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success 
                                    ? l10n.added_to_playlist 
                                    : 'Failed to add track to playlist'
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showArtistPicker(BuildContext context, TrackInterface track) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  l10n.go_to_artist,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: track.artistIds.length,
                  itemBuilder: (context, index) {
                    final artistId = track.artistIds[index];
                    final artistName = track.artistNames.length > index 
                        ? track.artistNames[index] 
                        : 'Unknown Artist';
                        
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(artistName),
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/artist/$artistId');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTrackDetails(BuildContext context, TrackInterface track) {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.details),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow(l10n.title, track.name),
            _detailRow(l10n.artist, track.artistNames.join(', ')),
            if (track.albumName != null) _detailRow(l10n.album, track.albumName!),
            _detailRow(l10n.duration, _formatDuration(Duration(milliseconds: track.durationMs))),
            _detailRow('ID', track.id),
            _detailRow('Platform', track.platform),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _buildBackground(String? imageUrl) {
    return Stack(
      children: [
        if (imageUrl != null)
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(color: Colors.black),
            ),
          )
        else
          Container(color: Colors.black),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLyricsView() {
    final lyricController = ref.watch(LyricController.provider);
    final l10n = AppLocalizations.of(context);
    
    return ValueListenableBuilder<LyricData?>(
      valueListenable: lyricController.currentLyrics,
      builder: (context, lyrics, _) {
        if (lyrics == null) {
          return Center(
            child: Text(
              l10n.no_lyrics_found,
              style: const TextStyle(color: Colors.white70),
            ),
          );
        }
        
        return lyricController.showSyncedLyrics.value
            ? SyncedLyricsWidget(lyrics: lyrics)
            : PlainLyricsWidget(lyrics: lyrics);
      },
    );
  }

  Widget _buildBottomActions(BuildContext context, AppLocalizations l10n) {
    final sleepTimer = ref.watch(sleepTimerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(_showLyrics ? Icons.lyrics : Icons.lyrics_outlined),
          color: _showLyrics ? Theme.of(context).colorScheme.primary : Colors.white70,
          onPressed: () => setState(() => _showLyrics = !_showLyrics),
          tooltip: l10n.lyrics,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.timer_outlined),
              color: sleepTimer != null ? Theme.of(context).colorScheme.primary : Colors.white70,
              onPressed: () => _showSleepTimerDialog(context, ref),
              tooltip: l10n.sleep_timer,
            ),
            if (sleepTimer != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${sleepTimer.inMinutes}',
                    style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.equalizer_outlined),
          color: Colors.white70,
          onPressed: () => _showEqualizer(context),
          tooltip: l10n.equalizer,
        ),
        IconButton(
          icon: const Icon(Icons.playlist_play),
          color: Colors.white70,
          onPressed: () => _showQueue(context),
          tooltip: l10n.queue,
        ),
      ],
    );
  }

  void _showQueue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(
        heightFactor: 0.7,
        child: PlayerQueueSheet(),
      ),
    );
  }
}
