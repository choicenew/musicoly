import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 动态音乐频谱波形律动动效组件 (Audio Spectrum Visualizer Bar Animation)
class MusicVisualizerWidget extends StatefulWidget {
  final bool isPlaying;
  final Color barColor;
  final int barCount;

  const MusicVisualizerWidget({
    super.key,
    required this.isPlaying,
    this.barColor = Colors.greenAccent,
    this.barCount = 5,
  });

  @override
  State<MusicVisualizerWidget> createState() => _MusicVisualizerWidgetState();
}

class _MusicVisualizerWidgetState extends State<MusicVisualizerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.isPlaying) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(MusicVisualizerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(widget.barCount, (index) {
            final factor = (index + 1) * 0.7;
            final heightMultiplier = math.sin(_controller.value * math.pi * factor).abs();
            final height = widget.isPlaying ? (8.0 + heightMultiplier * 16.0) : 4.0;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 3.5,
              height: height,
              decoration: BoxDecoration(
                color: widget.barColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            );
          }),
        );
      },
    );
  }
}
