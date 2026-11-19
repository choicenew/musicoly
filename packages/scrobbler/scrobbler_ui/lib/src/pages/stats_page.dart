import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('听歌统计 (Listening Statistics)'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.bar_chart, size: 36),
              title: Text('累计播放曲目: 1,280 首'),
              subtitle: Text('估算听歌时长: 85 小时'),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(Icons.person, size: 36),
              title: Text('最常听歌手: Jay Chou'),
              subtitle: Text('播放占比: 32%'),
            ),
          ),
        ],
      ),
    );
  }
}
