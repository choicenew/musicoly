import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/features/lyrics/controllers/lyrics_controller.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/core/base/interfaces/media/track_interface.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/synced_lyrics_widget.dart';
import 'package:pyro_music/presentation/pages/lyrics/widgets/plain_lyrics_widget.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';

/// 歌词页面
class LyricsPage extends StatelessWidget {
  /// 构造函数
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lyricsController = Provider.of<LyricsController>(context);
    final playerState = Provider.of<PlayerStateNotifier>(context);
    // Access the ValueNotifier's value property
    final TrackInterface? currentTrack = playerState.currentTrack.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('歌词'),
        actions: [
          // 同步歌词切换按钮
          ValueListenableBuilder<bool>(
            valueListenable: lyricsController.showSyncedLyrics,
            builder: (context, showSynced, _) {
              return IconButton(
                icon: Icon(showSynced ? Icons.sync : Icons.sync_disabled),
                tooltip: showSynced ? '显示普通歌词' : '显示同步歌词',
                onPressed: lyricsController.toggleSyncedLyrics,
              );
            },
          ),
          // 编辑模式切换按钮
          ValueListenableBuilder<bool>(
            valueListenable: lyricsController.isEditMode,
            builder: (context, isEditMode, _) {
              return IconButton(
                icon: Icon(isEditMode ? Icons.edit_off : Icons.edit),
                tooltip: isEditMode ? '退出编辑模式' : '进入编辑模式',
                onPressed: lyricsController.toggleEditMode,
              );
            },
          ),
          // 更多选项菜单
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export':
                  _exportLyrics(context, lyricsController);
                  break;
                case 'import':
                  _importLyrics(context, lyricsController, currentTrack);
                  break;
                case 'search':
                  _searchLyrics(context, lyricsController, currentTrack);
                  break;
                case 'settings':
                  _showLyricsSettings(context, lyricsController);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'export',
                child: ListTile(
                  leading: Icon(Icons.file_download),
                  title: Text('导出歌词'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'import',
                child: ListTile(
                  leading: Icon(Icons.file_upload),
                  title: Text('导入歌词'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'search',
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('搜索歌词'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('歌词设置'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: currentTrack == null
          ? const Center(child: Text('没有正在播放的曲目'))
          : ValueListenableBuilder(
              valueListenable: lyricsController.currentLyrics,
              builder: (context, lyrics, _) {
                if (lyrics == null) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadingIndicator(),
                        SizedBox(height: 16),
                        Text('加载歌词中...'),
                      ],
                    ),
                  );
                }
                
                return ValueListenableBuilder(
                  valueListenable: lyricsController.showSyncedLyrics,
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
  void _exportLyrics(BuildContext context, LyricsController controller) {
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
  void _importLyrics(BuildContext context, LyricsController controller, dynamic currentTrack) {
    if (currentTrack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有正在播放的曲目')),
      );
      return;
    }
    
    final textController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导入LRC歌词'),
        content: TextField(
          controller: textController,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: '粘贴LRC格式歌词...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final lrcContent = textController.text.trim();
              if (lrcContent.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('歌词内容不能为空')),
                );
                return;
              }
              
              final success = await controller.importFromLRC(lrcContent, currentTrack);
              Navigator.of(context).pop();
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? '导入成功' : '导入失败')),
              );
            },
            child: const Text('导入'),
          ),
        ],
      ),
    );
  }
  
  // 搜索歌词
  void _searchLyrics(BuildContext context, LyricsController controller, dynamic currentTrack) {
    if (currentTrack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有正在播放的曲目')),
      );
      return;
    }
    
    final textController = TextEditingController();
    textController.text = '${currentTrack.name} ${currentTrack.artistNames.join(' ')}';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索歌词'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '输入搜索关键词...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final query = textController.text.trim();
              if (query.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('搜索关键词不能为空')),
                );
                return;
              }
              
              Navigator.of(context).pop();
              
              // 显示搜索结果
              final results = await controller.searchLyrics(query);
              if (results.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('未找到匹配的歌词')),
                );
                return;
              }
              
              // 显示搜索结果列表
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('搜索结果'),
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 300,
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final lyrics = results[index];
                        return ListTile(
                          title: Text(lyrics.track.name),
                          // 使用 artistNames 替代 artists
                          subtitle: Text(lyrics.track.artistNames.join(', ')),
                          trailing: Icon(lyrics.isSynced ? Icons.sync : Icons.sync_disabled),
                          onTap: () async {
                            await controller.saveLyrics(lyrics);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('歌词应用成功')),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('关闭'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('搜索'),
          ),
        ],
      ),
    );
  }
  
  // 显示歌词设置
  void _showLyricsSettings(BuildContext context, LyricsController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('歌词设置'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 自动滚动
              ValueListenableBuilder<bool>(
                valueListenable: controller.autoScroll,
                builder: (context, autoScroll, _) {
                  return SwitchListTile(
                    title: const Text('自动滚动'),
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
                    title: const Text('高亮当前行'),
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
                    title: const Text('显示翻译'),
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
                    title: const Text('字体大小'),
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
                    title: const Text('行间距'),
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
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}