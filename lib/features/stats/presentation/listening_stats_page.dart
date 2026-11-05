import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 听歌数据统计分析页面 (Listening Statistics & Analytics)
class ListeningStatsPage extends ConsumerWidget {
  const ListeningStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('听歌统计与分析'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Overall Summary Cards Row
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: '累计播放单曲',
                    value: '1,248 首',
                    icon: Icons.music_note_rounded,
                    color: colorScheme.primaryContainer,
                    onColor: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: '播放总时长',
                    value: '86.5 小时',
                    icon: Icons.timer_rounded,
                    color: colorScheme.secondaryContainer,
                    onColor: colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Top Artists Section
            Text(
              '最常听歌手 Top 5',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    _buildArtistStatTile(context, index: 1, name: '周杰伦', playCount: 342, progress: 1.0),
                    const Divider(indent: 16, endIndent: 16, height: 1),
                    _buildArtistStatTile(context, index: 2, name: '林俊杰', playCount: 215, progress: 0.63),
                    const Divider(indent: 16, endIndent: 16, height: 1),
                    _buildArtistStatTile(context, index: 3, name: '陈奕迅', playCount: 189, progress: 0.55),
                    const Divider(indent: 16, endIndent: 16, height: 1),
                    _buildArtistStatTile(context, index: 4, name: '邓紫棋', playCount: 142, progress: 0.41),
                    const Divider(indent: 16, endIndent: 16, height: 1),
                    _buildArtistStatTile(context, index: 5, name: '五月天', playCount: 98, progress: 0.28),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Weekly Activity Heatmap/Chart Placeholder
            Text(
              '本周听歌趋势',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAlignment.end,
                        children: [
                          _buildBarItem(context, '周一', 0.4),
                          _buildBarItem(context, '周二', 0.65),
                          _buildBarItem(context, '周三', 0.3),
                          _buildBarItem(context, '周四', 0.85),
                          _buildBarItem(context, '周五', 0.9),
                          _buildBarItem(context, '周六', 1.0),
                          _buildBarItem(context, '周日', 0.7),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color onColor,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAlignment.start,
        children: [
          Icon(icon, color: onColor, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: onColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: onColor.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistStatTile(
    BuildContext context, {
    required int index,
    required String name,
    required int playCount,
    required double progress,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: index <= 3 ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        child: Text(
          '$index',
          style: TextStyle(
            color: index <= 3 ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ),
      trailing: Text(
        '$playCount 次',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBarItem(BuildContext context, String dayLabel, double ratio) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisSize.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 24,
          height: 80 * ratio,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          dayLabel,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
