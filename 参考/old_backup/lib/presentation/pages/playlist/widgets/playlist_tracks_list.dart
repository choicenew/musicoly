import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/playlist_model.dart';

class PlaylistTracksList extends StatelessWidget {
  const PlaylistTracksList({super.key});

  @override
  Widget build(BuildContext context) {
    // 实际应从播放列表数据中获取曲目列表
    final tracks = <dynamic>[]; 

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        // 这里应使用实际的曲目组件
        return ListTile(
          title: Text('Track ${index + 1}'),
          subtitle: const Text('Artist Name'),
        );
      },
    );
  }
}