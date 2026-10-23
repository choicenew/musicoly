import 'package:flutter/material.dart';

/// 支持部分组件
class SupportSection extends StatelessWidget {
  /// 构造函数
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '支持与帮助',
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
                  leading: const Icon(Icons.help_outline),
                  title: const Text('帮助中心'),
                  subtitle: const Text('查看使用指南和常见问题'),
                  onTap: () {
                    // TODO: 实现跳转到帮助中心逻辑
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.feedback_outlined),
                  title: const Text('反馈问题'),
                  subtitle: const Text('向我们报告问题或提出建议'),
                  onTap: () {
                    // TODO: 实现问题反馈逻辑
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('支持项目'),
                  subtitle: const Text('如果您喜欢这个项目，欢迎给我们一个Star'),
                  onTap: () {
                    // TODO: 实现项目支持逻辑
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
