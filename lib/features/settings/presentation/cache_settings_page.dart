import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/services/audio_cache_manager.dart';
import 'package:pyro_music/core/services/service_registry.dart';

/// 缓存与智能预加载设置页面 (Audio Cache & Pre-fetch Settings)
class CacheSettingsPage extends ConsumerStatefulWidget {
  const CacheSettingsPage({super.key});

  @override
  ConsumerState<CacheSettingsPage> createState() => _CacheSettingsPageState();
}

class _CacheSettingsPageState extends ConsumerState<CacheSettingsPage> {
  int _totalCacheBytes = 0;
  bool _autoPrefetchNext = true;
  double _maxLimitGB = 2.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState() ;
    _loadCacheStats();
  }

  Future<void> _loadCacheStats() async {
    final cacheManager = ServiceRegistry().getService<AudioCacheManager>('audio_cache_manager');
    if (cacheManager != null) {
      final size = await cacheManager.getTotalCacheSize();
      setState(() {
        _totalCacheBytes = size;
        _maxLimitGB = cacheManager.maxCacheSizeBytes / (1024 * 1024 * 1024);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final usedMB = _totalCacheBytes / (1024 * 1024);
    final maxMB = _maxLimitGB * 1024;
    final ratio = maxMB > 0 ? (usedMB / maxMB).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('存储与缓存管理'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Cache Storage Usage Card
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '音频缓存占用',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${_formatBytes(_totalCacheBytes)} / ${_maxLimitGB.toStringAsFixed(1)} GB',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 10,
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ratio > 0.9 ? colorScheme.error : colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '当缓存占用达到最大上限时，系统将自动基于 LRU 策略清理最早未播放的音频缓存文件。',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Cache Limit Slider
                Text(
                  '最大缓存容量上限',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        Slider(
                          value: _maxLimitGB,
                          min: 0.5,
                          max: 10.0,
                          divisions: 19,
                          label: '${_maxLimitGB.toStringAsFixed(1)} GB',
                          onChanged: (value) {
                            setState(() => _maxLimitGB = value);
                            final bytes = (value * 1024 * 1024 * 1024).toInt();
                            ServiceRegistry()
                                .getService<AudioCacheManager>('audio_cache_manager')
                                ?.setMaxCacheSize(bytes);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Auto Pre-fetching Toggle
                SwitchListTile(
                  value: _autoPrefetchNext,
                  title: const Text('播放队列智能预加载'),
                  subtitle: const Text('自动在后台预下载下一首歌曲，消除网络波动造成的切歌停顿'),
                  secondary: const Icon(Icons.cloud_download_rounded),
                  onChanged: (value) {
                    setState(() => _autoPrefetchNext = value);
                  },
                ),
                const Divider(height: 32),

                // Action Buttons
                ListTile(
                  leading: Icon(Icons.cleaning_services_rounded, color: colorScheme.error),
                  title: const Text('一键清空音频缓存'),
                  subtitle: const Text('清理所有本地已缓存的离线音频文件'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final cacheManager = ServiceRegistry().getService<AudioCacheManager>('audio_cache_manager');
                    await cacheManager?.clearAllCache();
                    await _loadCacheStats();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('已成功清理所有离线音频缓存')),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
