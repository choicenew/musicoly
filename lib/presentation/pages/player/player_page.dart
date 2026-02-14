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
    final colorScheme = theme.colorScheme;

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
                      // 歌曲信息 (如果封面在中间，这里可以放歌曲名)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 48), // Spacer for heart icon balance
                          Expanded(
                            child: Text(
                              track.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              track.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: track.isFavorite ? Colors.red : Colors.white70,
                            ),
                            onPressed: () async {
                              await ref.read(playlistServiceProvider).toggleFavorite(track.id);
                              // The playback state might not update immediately if it's cached.
                              // But the UI will rebuild if the provider emits a new state.
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        track.artistNames.join(', '),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
    
    return ValueListenableBuilder<LyricData?>(
      valueListenable: lyricController.currentLyrics,
      builder: (context, lyrics, _) {
        if (lyrics == null) {
          return const Center(
            child: Text(
              "No Lyrics Found",
              style: TextStyle(color: Colors.white70),
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
    final remainingTime = ref.watch(sleepTimerProvider);

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
              color: remainingTime != null ? Theme.of(context).colorScheme.primary : Colors.white70,
              onPressed: () => _showSleepTimerDialog(context),
              tooltip: l10n.sleep_timer,
            ),
            if (remainingTime != null)
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
                    '${remainingTime.inMinutes}',
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

  void _showSleepTimerDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(sleepTimerProvider.notifier);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.sleep_timer,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTimerOption(context, '15 min', const Duration(minutes: 15), notifier),
            _buildTimerOption(context, '30 min', const Duration(minutes: 30), notifier),
            _buildTimerOption(context, '45 min', const Duration(minutes: 45), notifier),
            _buildTimerOption(context, '60 min', const Duration(minutes: 60), notifier),
            _buildTimerOption(context, '90 min', const Duration(minutes: 90), notifier),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.timer_off_outlined, color: Colors.red),
              title: Text(l10n.cancel, style: const TextStyle(color: Colors.red)),
              onTap: () {
                notifier.stop();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerOption(BuildContext context, String title, Duration duration, SleepTimerNotifier notifier) {
    return ListTile(
      leading: const Icon(Icons.access_time),
      title: Text(title),
      onTap: () {
        notifier.start(duration);
        Navigator.pop(context);
      },
    );
  }

  void _showEqualizer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(16),
        child: const Wrap(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: 40,
                  height: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                ),
              ),
            ),
            EqualizerSettings(),
          ],
        ),
      ),
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
