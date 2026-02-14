import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

class MiniPlayer extends ConsumerStatefulWidget {
  const MiniPlayer({super.key});

  @override
  ConsumerState<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends ConsumerState<MiniPlayer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragOffset = 0.0;
  static const double miniHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset -= details.primaryDelta!;
      if (_dragOffset < 0) _dragOffset = 0;
    });
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset > 100 || details.primaryVelocity! < -500) {
      // 展开到全屏播放器
      context.push('/lyrics');
    }
    setState(() {
      _dragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerStateProvider);
    final track = playerState.currentTrack;

    if (track == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      transform: Matrix4.translationValues(0, -_dragOffset * 0.2, 0),
      child: GestureDetector(
        onVerticalDragUpdate: _handleVerticalDragUpdate,
        onVerticalDragEnd: _handleVerticalDragEnd,
        onTap: () => context.push('/lyrics'),
        child: Container(
          height: miniHeight,
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: [
                // 进度条背景
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 3,
                  child: Container(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                // 进度条
                if (track.durationMs > 0)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: MediaQuery.of(context).size.width * 
                           (playerState.position / track.durationMs).clamp(0.0, 1.0),
                    height: 3,
                    child: Container(
                      color: colorScheme.primary,
                    ),
                  ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      // 封面
                      Hero(
                        tag: 'player_art',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: track.imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: track.imageUrl!,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 52,
                                  height: 52,
                                  color: colorScheme.surfaceContainer,
                                  child: const Icon(Icons.music_note),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // 标题和艺术家
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              track.artistNames.isNotEmpty ? track.artistNames.join(', ') : 'Unknown Artist',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 收藏按钮 (假装有)
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),

                      // 控制按钮
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: colorScheme.onSurface,
                            ),
                            onPressed: () {
                              final notifier = ref.read(playerStateProvider.notifier);
                              if (playerState.isPlaying) {
                                notifier.pause();
                              } else {
                                notifier.resume();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            onPressed: () => ref.read(playerStateProvider.notifier).next(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
