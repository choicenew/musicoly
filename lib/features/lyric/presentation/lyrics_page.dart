import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/lyric/controllers/lyric_controller.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';
import 'package:pyro_music/presentation/widgets/common/loading_indicator.dart';
import 'package:pyro_music/generated/app_localizations.dart';

import 'widgets/synced_lyrics_widget.dart';
import 'widgets/plain_lyrics_widget.dart';

/// 歌词页面
class LyricsPage extends ConsumerWidget {
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lyricController = ref.watch(LyricController.provider);
    final l10n = AppLocalizations.of(context);
    final currentTrack = ref.watch(playerStateProvider.notifier).currentTrack;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lyrics),
        actions: [
          IconButton(
            icon: Icon(lyricController.showSyncedLyrics.value ? Icons.sync : Icons.sync_disabled),
            tooltip: lyricController.showSyncedLyrics.value ? l10n.show_plain_lyrics : l10n.show_synced_lyrics,
            onPressed: lyricController.toggleSyncedLyrics,
          ),
          IconButton(
            icon: Icon(lyricController.isEditMode.value ? Icons.edit_off : Icons.edit),
            tooltip: lyricController.isEditMode.value ? l10n.exit_edit_mode : l10n.enter_edit_mode,
            onPressed: lyricController.toggleEditMode,
          ),
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
          : ValueListenableBuilder(
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
                      return SyncedLyricsWidget(lyrics: lyrics);
                    } else {
                      return PlainLyricsWidget(lyrics: lyrics);
                    }
                  },
                );
              },
            ),
    );
  }

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
                  SnackBar(content: Text(success ? l10n.lyrics_imported_successfully : l10n.failed_to_import_lyrics)),
                );
              }
            },
            child: Text(l10n.import),
          ),
        ],
      ),
    );
  }

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

              final results = await controller.searchLyrics(query);
              if (!context.mounted) return;

              if (results.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.no_lyrics_found)),
                );
                return;
              }

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
