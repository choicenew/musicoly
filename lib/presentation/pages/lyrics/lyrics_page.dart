import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/core/base/interfaces/lyric/lyric_interface.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/synced_lyrics_widget.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/plain_lyrics_widget.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// 歌词页面
class LyricsPage extends ConsumerWidget {
  /// 构造函数
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lyricController = ref.watch(LyricController.provider);
    final l10n = AppLocalizations.of(context);
    // 仅监听 currentTrack 的变化，提高性能
    final currentTrack = ref.watch(playerStateProvider.select((s) => s.currentTrack));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lyrics),
        actions: [
          // 同步歌词切换按钮
          IconButton(
            icon: Icon(lyricController.showSyncedLyrics.value ? Icons.sync : Icons.sync_disabled),
            tooltip: lyricController.showSyncedLyrics.value ? l10n.show_plain_lyrics : l10n.show_synced_lyrics,
            onPressed: lyricController.toggleSyncedLyrics,
          ),
          // 编辑模式切换按钮
          IconButton(
            icon: Icon(lyricController.isEditMode.value ? Icons.edit_off : Icons.edit),
            tooltip: lyricController.isEditMode.value ? l10n.exit_edit_mode : l10n.enter_edit_mode,
            onPressed: lyricController.toggleEditMode,
          ),
          // 更多选项菜单
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export':
                  _exportLyrics(context, lyricController);
                  break;
                case 'import':
                  _importLyrics(context, lyricController, currentTrack);
                  break;
                case 'search':
                  _searchLyrics(context, lyricController, currentTrack);
                  break;
                case 'settings':
                  _showLyricsSettings(context, lyricController);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'export',
                child: ListTile(
                  leading: const Icon(Icons.file_download),
                  title: Text(l10n.export_lyrics),
                ),
              ),
              PopupMenuItem<String>(
                value: 'import',
                child: ListTile(
                  leading: const Icon(Icons.file_upload),
                  title: Text(l10n.import_lyrics),
                ),
              ),
              PopupMenuItem<String>(
                value: 'search',
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(l10n.search_lyrics),
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(l10n.lyrics_settings),
                ),
              ),
            ],
          ),
        ],
      ),
      body: currentTrack == null
          ? Center(child: Text(l10n.no_track_playing))
          : ValueListenableBuilder<LyricData?>(
              valueListenable: lyricController.currentLyrics,
              builder: (context, lyrics, _) {
                if (lyrics == null) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingIndicator(),
                        SizedBox(height: 16),
                        Text('加载歌词中...'),
                      ],
                    ),
                  );
                }
                
                return ValueListenableBuilder<bool>(
                  valueListenable: lyricController.showSyncedLyrics,
                  builder: (context, showSynced, _) {
                    if (showSynced && lyrics.isSynced) {
                      // 使用正确的组件名称
                      return SyncedLyricsWidget(lyrics: lyrics);
                    } else {
                      // 使用正确的组件名称
                      return PlainLyricsWidget(lyrics: lyrics);
                    }
                  },
                );
              },
            ),
    );
  }
  
  // 导出歌词
  void _exportLyrics(BuildContext context, LyricController controller) {
    final lyrics = controller.currentLyrics.value;
    if (lyrics == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有可导出的歌词')),
      );
      return;
    }
    
    if (!lyrics.isSynced) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('只能导出同步歌词')),
      );
      return;
    }
    
    final lrcContent = controller.exportToLRC();
    // 这里应该实现导出到文件的逻辑
    // 简化处理，显示导出内容
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('LRC歌词'),
        content: SingleChildScrollView(
          child: SelectableText(lrcContent),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
  
  // 导入歌词
  void _importLyrics(BuildContext context, LyricController controller, dynamic currentTrack) {
    if (currentTrack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有正在播放的曲目')),
      );
      return;
    }
    
    final textController = TextEditingController();
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.import_lyrics),
        content: TextField(
          controller: textController,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: l10n.paste_lrc_here,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              final lrcContent = textController.text.trim();
              if (lrcContent.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.lyrics_content_cannot_be_empty)),
                );
                return;
              }
              
              final success = await controller.importFromLRC(lrcContent, currentTrack);
              if (context.mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(success ? l10n.import_success : l10n.import_failed(''))),
                );
              }
            },
            child: Text(l10n.import),
          ),
        ],
      ),
    );
  }
  
  // 搜索歌词
  void _searchLyrics(BuildContext context, LyricController controller, dynamic currentTrack) {
    final l10n = AppLocalizations.of(context);
    if (currentTrack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.no_track_playing)),
      );
      return;
    }
    
    final textController = TextEditingController();
    textController.text = '${currentTrack.name} ${currentTrack.artistNames.join(' ')}';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.search_lyrics),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: l10n.input_search_keywords,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              final query = textController.text.trim();
              if (query.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.search_keywords_cannot_be_empty)),
                );
                return;
              }
              
              if (context.mounted) {
                Navigator.of(context).pop();
              }
              
              // 显示搜索结果
              final results = await controller.searchLyrics(query);
              if (!context.mounted) return;

              if (results.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.no_lyrics_found)),
                );
                return;
              }
              
              // 显示搜索结果列表
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.search_results),
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 300,
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final lyrics = results[index];
                        return ListTile(
                          title: Text(lyrics.trackName),
                          subtitle: Text(lyrics.artistNames),
                          trailing: Icon(lyrics.isSynced ? Icons.sync : Icons.sync_disabled),
                          onTap: () async {
                            await controller.saveLyrics(lyrics);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.lyrics_applied_successfully)),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.cancel),
                    ),
                  ],
                ),
              );
            },
            child: Text(l10n.search),
          ),
        ],
      ),
    );
  }
  
  // 显示歌词设置
  void _showLyricsSettings(BuildContext context, LyricController controller) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.lyrics_settings),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 自动滚动
              ValueListenableBuilder<bool>(
                valueListenable: controller.autoScroll,
                builder: (context, autoScroll, _) {
                  return SwitchListTile(
                    title: Text(l10n.auto_scroll),
                    value: autoScroll,
                    onChanged: (value) {
                      controller.toggleAutoScroll();
                    },
                  );
                },
              ),
              // 高亮当前行
              ValueListenableBuilder<bool>(
                valueListenable: controller.highlightCurrentLine,
                builder: (context, highlight, _) {
                  return SwitchListTile(
                    title: Text(l10n.highlight_current_line),
                    value: highlight,
                    onChanged: (value) {
                      controller.toggleHighlightCurrentLine();
                    },
                  );
                },
              ),
              // 显示翻译
              ValueListenableBuilder<bool>(
                valueListenable: controller.showTranslation,
                builder: (context, showTranslation, _) {
                  return SwitchListTile(
                    title: Text(l10n.show_translation),
                    value: showTranslation,
                    onChanged: (value) {
                      controller.toggleShowTranslation();
                    },
                  );
                },
              ),
              // 字体大小
              ValueListenableBuilder<double>(
                valueListenable: controller.fontSize,
                builder: (context, fontSize, _) {
                  return ListTile(
                    title: Text(l10n.font_size),
                    subtitle: Slider(
                      value: fontSize,
                      min: 12.0,
                      max: 24.0,
                      divisions: 12,
                      label: fontSize.toStringAsFixed(1),
                      onChanged: (value) {
                        controller.setFontSize(value);
                      },
                    ),
                  );
                },
              ),
              // 行间距
              ValueListenableBuilder<double>(
                valueListenable: controller.lineSpacing,
                builder: (context, lineSpacing, _) {
                  return ListTile(
                    title: Text(l10n.line_spacing),
                    subtitle: Slider(
                      value: lineSpacing,
                      min: 1.0,
                      max: 3.0,
                      divisions: 10,
                      label: lineSpacing.toStringAsFixed(1),
                      onChanged: (value) {
                        controller.setLineSpacing(value);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}
