import 'package:flutter/material.dart';

class PlayerHeader extends StatelessWidget {
  final String title;
  final String artist;
  final VoidCallback onClose;

  const PlayerHeader({
    super.key,
    required this.title,
    required this.artist,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_down, size: 32),
        onPressed: onClose,
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            artist,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // TODO: 更多操作
          },
        ),
      ],
    );
  }
}
