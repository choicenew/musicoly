import 'dart:math' as math;
import 'package:flutter/material.dart';

/// PulseMusic Inspired Interactive Audio Waveform Progress Bar Widget
class WaveformProgressBarUI extends StatelessWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<Duration>? onSeek;
  final Color activeColor;
  final Color inactiveColor;

  const WaveformProgressBarUI({
    super.key,
    required this.currentPosition,
    required this.totalDuration,
    this.onSeek,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x55FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalDuration.inMilliseconds > 0
        ? (currentPosition.inMilliseconds / totalDuration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final localX = details.localPosition.dx;
          final relative = (localX / box.size.width).clamp(0.0, 1.0);
          final targetMs = (totalDuration.inMilliseconds * relative).toInt();
          onSeek?.call(Duration(milliseconds: targetMs));
        }
      },
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final localX = details.localPosition.dx;
          final relative = (localX / box.size.width).clamp(0.0, 1.0);
          final targetMs = (totalDuration.inMilliseconds * relative).toInt();
          onSeek?.call(Duration(milliseconds: targetMs));
        }
      },
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: CustomPaint(
          painter: _WaveformPainter(
            progress: progress,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  _WaveformPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const barWidth = 3.0;
    const barGap = 2.0;
    final totalBars = (size.width / (barWidth + barGap)).floor();

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < totalBars; i++) {
      final barProgress = i / totalBars;
      final isPlayed = barProgress <= progress;
      final paint = isPlayed ? activePaint : inactivePaint;

      // 使用伪随机平滑波形模拟音频波峰
      final heightFactor = (math.sin(i * 0.35) * 0.4 + 0.6).clamp(0.15, 1.0);
      final barHeight = size.height * heightFactor * 0.8;

      final x = i * (barWidth + barGap);
      final y = (size.height - barHeight) / 2;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(1.5),
      );

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
