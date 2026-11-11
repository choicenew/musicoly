import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 沉浸式 Canvas 互动音频粒子与光晕视觉化器 (Spotify Canvas Style)
class InteractiveAudioCanvasWidget extends StatefulWidget {
  final bool isPlaying;
  final Color primaryColor;

  const InteractiveAudioCanvasWidget({
    super.key,
    required this.isPlaying,
    required this.primaryColor,
  });

  @override
  State<InteractiveAudioCanvasWidget> createState() => _InteractiveAudioCanvasWidgetState();
}

class _InteractiveAudioCanvasWidgetState extends State<InteractiveAudioCanvasWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 35; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 4 + 2,
        speedY: _random.nextDouble() * 0.002 + 0.001,
        alpha: _random.nextDouble() * 0.6 + 0.2,
      ));
    }
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
        if (widget.isPlaying) {
          for (var p in _particles) {
            p.y -= p.speedY;
            if (p.y < 0) p.y = 1.0;
          }
        }

        return CustomPaint(
          painter: _CanvasParticlePainter(
            particles: _particles,
            primaryColor: widget.primaryColor,
            animationValue: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  double size;
  double speedY;
  double alpha;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedY,
    required this.alpha,
  });
}

class _CanvasParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Color primaryColor;
  final double animationValue;

  _CanvasParticlePainter({
    required this.particles,
    required this.primaryColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // 绘制流光渐变背景网格
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = size.width * (0.6 + math.sin(animationValue * 2 * math.pi) * 0.1);

    paint.shader = RadialGradient(
      colors: [
        primaryColor.withValues(alpha: 0.35),
        primaryColor.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);

    // 绘制漂浮音频粒子
    for (var p in particles) {
      paint.shader = null;
      paint.color = Colors.white.withValues(alpha: p.alpha);
      final offset = Offset(p.x * size.width, p.y * size.height);
      canvas.drawCircle(offset, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CanvasParticlePainter oldDelegate) => true;
}
