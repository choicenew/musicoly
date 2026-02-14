import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/player/mini_player.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final hasTrack = playerState.currentTrack != null;

    return Scaffold(
      body: Stack(
        children: [
          // 主内容
          Padding(
            padding: EdgeInsets.only(bottom: hasTrack ? 80.0 : 0.0),
            child: child,
          ),
          
          // 迷你播放器
          if (hasTrack)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MiniPlayer(),
            ),
        ],
      ),
    );
  }
}
