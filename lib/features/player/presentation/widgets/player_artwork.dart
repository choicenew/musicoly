import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Spotube & Musify Style Animated Artwork Widget
class PlayerArtwork extends StatefulWidget {
  final String? imageUrl;
  final bool isPlaying;
  final VoidCallback? onTap;

  const PlayerArtwork({
    super.key,
    this.imageUrl,
    this.isPlaying = true,
    this.onTap,
  });

  @override
  State<PlayerArtwork> createState() => _PlayerArtworkState();
}

class _PlayerArtworkState extends State<PlayerArtwork>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    if (widget.isPlaying) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(PlayerArtwork oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: [
                BoxShadow(
                  color: widget.isPlaying
                      ? theme.colorScheme.primary.withValues(alpha: 0.35)
                      : Colors.black.withValues(alpha: 0.3),
                  blurRadius: widget.isPlaying ? 40 : 25,
                  spreadRadius: widget.isPlaying ? 4 : 0,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0),
              child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[900],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[900],
      child: const Icon(
        Icons.music_note_rounded,
        size: 100,
        color: Colors.white24,
      ),
    );
  }
}
