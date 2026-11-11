import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Spotube & Namida Style Dynamic Fluid Ambient Mesh Gradient Animation Background
class AmbientMeshBackground extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Widget child;

  const AmbientMeshBackground({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.child,
  });

  @override
  State<AmbientMeshBackground> createState() => _AmbientMeshBackgroundState();
}

class _AmbientMeshBackgroundState extends State<AmbientMeshBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value;
        final angle = progress * 2 * math.pi;

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                math.cos(angle) * 0.6,
                math.sin(angle) * 0.6,
              ),
              radius: 1.2,
              colors: [
                widget.primaryColor.withValues(alpha: 0.45),
                widget.secondaryColor.withValues(alpha: 0.25),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
