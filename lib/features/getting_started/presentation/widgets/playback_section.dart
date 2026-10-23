import 'package:flutter/material.dart';

/// 播放设置部分组件
class PlaybackSection extends StatelessWidget {
  /// 构造函数
  const PlaybackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '播放设置',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text('音频质量'),
                  subtitle: const Text('选择您喜欢的音频质量'),
                  trailing: DropdownButton<String>(
                    value: 'HIGH',
                    items: const [
                      DropdownMenuItem(value: 'LOW', child: Text('低质量')),
                      DropdownMenuItem(value: 'MEDIUM', child: Text('中等质量')),
                      DropdownMenuItem(value: 'HIGH', child: Text('高质量')),
                    ],
                    onChanged: (value) {
                      // TODO: 实现音频质量切换逻辑
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('自动播放'),
                  subtitle: const Text('播放完当前歌曲后自动播放下一首'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: 实现自动播放切换逻辑
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
