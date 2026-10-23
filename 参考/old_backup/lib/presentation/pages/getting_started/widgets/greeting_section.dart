import 'package:flutter/material.dart';

/// 欢迎部分组件
class GreetingSection extends StatelessWidget {
  /// 构造函数
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '欢迎使用 Pyro Music',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '开始使用前，让我们先进行一些基本设置',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/pyro_music-logo.png',
          height: 120,
          width: 120,
        ),
      ],
    );
  }
}
