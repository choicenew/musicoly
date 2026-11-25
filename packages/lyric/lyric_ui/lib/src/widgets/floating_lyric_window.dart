import 'package:flutter/material.dart';

/// 桌面端系统级置顶悬浮歌词小窗组件 (Floating Lyric Window UI)
class FloatingLyricWindowUI extends StatelessWidget {
  final String currentLyricText;
  final String? currentTranslation;
  final bool isLocked;
  final VoidCallback onToggleLock;
  final VoidCallback onClose;

  const FloatingLyricWindowUI({
    super.key,
    required this.currentLyricText,
    this.currentTranslation,
    required this.isLocked,
    required this.onToggleLock,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hoverColor = isLocked ? Colors.transparent : Colors.black45;

    return MouseRegion(
      cursor: isLocked ? SystemMouseCursors.basic : SystemMouseCursors.move,
      child: Material(
        color: hoverColor, // 根据锁定状态切换背景透明度
        borderRadius: BorderRadius.circular(12),
        elevation: isLocked ? 0 : 8,
        child: Stack(
          children: [
            // 歌词正文显示区
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentLyricText.isNotEmpty ? currentLyricText : '... Musicoly ...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    if (currentTranslation != null && currentTranslation!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        currentTranslation!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.8),
                              blurRadius: 4,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // 悬浮窗控制栏 (悬停或未锁定时显示)
            if (!isLocked)
              Positioned(
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.push_pin, size: 18, color: Colors.white70),
                      tooltip: '锁定窗口 (鼠标穿透)',
                      onPressed: onToggleLock,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18, color: Colors.white70),
                      tooltip: '关闭悬浮歌词',
                      onPressed: onClose,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
