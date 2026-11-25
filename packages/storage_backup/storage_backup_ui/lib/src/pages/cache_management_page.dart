import 'package:flutter/material.dart';

class CacheManagementPageUI extends StatelessWidget {
  const CacheManagementPageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('音频缓存与容量管理')),
      body: const Center(child: Text('2GB 自动边听边存缓存已启用')),
    );
  }
}
