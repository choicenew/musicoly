import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/core/base/services/audio_service.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';

class PlaybackSettings extends StatefulWidget {
  const PlaybackSettings({super.key});

  @override
  State<PlaybackSettings> createState() => _PlaybackSettingsState();
}

class _PlaybackSettingsState extends State<PlaybackSettings> {
  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<UserPreferencesProvider>();
    final audioService = context.read<AudioService>();
    final playerService = context.read<PlayerService>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 音频质量设置（使用音频服务）
            ListTile(
              title: const Text('音频质量'),
              subtitle: const Text('选择音频播放质量'),
              trailing: DropdownButton<String>(
                value: audioService.currentAudioQuality,
                items: const [
                  DropdownMenuItem(value: 'low', child: Text('低质量')),
                  DropdownMenuItem(value: 'medium', child: Text('中等质量')),
                  DropdownMenuItem(value: 'high', child: Text('高质量')),
                ],
                onChanged: (value) {
                  audioService.setAudioQuality(value!);
                },
              ),
            ),
            
            // 音量标准化（使用音频服务）
            SwitchListTile(
              value: audioService.currentVolumeNormalization,
              onChanged: (value) {
                audioService.setVolumeNormalization(value);
              },
            ),
            
            // 交叉淡入淡出（使用音频服务）
            ListTile(
              title: const Text('交叉淡入淡出'),
              subtitle: const Text('设置歌曲之间的过渡效果'), 
              trailing: DropdownButton<int>(
                value: preferences.crossfadeDuration,
                items: const [
                  DropdownMenuItem(value: 0, child: Text('关闭')),
                  DropdownMenuItem(value: 1, child: Text('1秒')),
                  DropdownMenuItem(value: 2, child: Text('2秒')),
                  DropdownMenuItem(value: 3, child: Text('3秒')),
                ],
                onChanged: (value) async {
                  final duration = Duration(seconds: value!);
                  // 同时更新用户偏好设置和音频服务
                  await preferences.setCrossfadeDuration(value);
                  await audioService.applyCrossfadeEffect(duration);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
