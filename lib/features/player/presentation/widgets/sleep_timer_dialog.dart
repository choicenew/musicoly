import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/player/providers/sleep_timer_provider.dart';

/// 睡眠定时器弹窗组件 (Sleep Timer Dialog)
class SleepTimerDialog extends ConsumerStatefulWidget {
  const SleepTimerDialog({super.key});

  @override
  ConsumerState<SleepTimerDialog> createState() => _SleepTimerDialogState();
}

class _SleepTimerDialogState extends ConsumerState<SleepTimerDialog> {
  int _selectedMinutes = 30;
  bool _stopAtEndOfTrack = false;
  bool _fadeOut = true;

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(sleepTimerProvider);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.bedtime, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('睡眠定时器'),
        ],
      ),
      content: timerState.isActive
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '剩余时间: ${_formatDuration(timerState.remainingTime)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(sleepTimerProvider.notifier).cancelTimer();
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text('取消定时器'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.errorContainer,
                    foregroundColor: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 8,
                  children: [15, 30, 45, 60, 90].map((mins) {
                    final isSelected = _selectedMinutes == mins;
                    return ChoiceChip(
                      label: Text('$mins 分钟'),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedMinutes = mins);
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('曲终停播'),
                  subtitle: const Text('等待当前歌曲播放完毕后停止'),
                  value: _stopAtEndOfTrack,
                  onChanged: (val) => setState(() => _stopAtEndOfTrack = val),
                ),
                SwitchListTile(
                  title: const Text('音量渐隐停播'),
                  subtitle: const Text('在倒计时最后 15 秒平滑降低音量'),
                  value: _fadeOut,
                  onChanged: (val) => setState(() => _fadeOut = val),
                ),
              ],
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
        if (!timerState.isActive)
          ElevatedButton(
            onPressed: () {
              ref.read(sleepTimerProvider.notifier).startTimer(
                    Duration(minutes: _selectedMinutes),
                    stopAtEndOfTrack: _stopAtEndOfTrack,
                    fadeOut: _fadeOut,
                  );
              Navigator.of(context).pop();
            },
            child: const Text('开启'),
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${duration.inHours > 0 ? '${duration.inHours}:' : ''}$mins:$secs';
  }
}
