import 'package:flutter/material.dart';

/// 区域设置部分组件
class RegionSection extends StatelessWidget {
  /// 构造函数
  const RegionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '区域设置',
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
                  title: const Text('语言'),
                  subtitle: const Text('选择您的首选语言'),
                  trailing: DropdownButton<String>(
                    value: 'zh_CN',
                    items: const [
                      DropdownMenuItem(value: 'zh_CN', child: Text('简体中文')),
                      DropdownMenuItem(value: 'en_US', child: Text('English')),
                      DropdownMenuItem(value: 'ja_JP', child: Text('日本語')),
                    ],
                    onChanged: (value) {
                      // TODO: 实现语言切换逻辑
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('地区'),
                  subtitle: const Text('选择您所在的地区'),
                  trailing: DropdownButton<String>(
                    value: 'CN',
                    items: const [
                      DropdownMenuItem(value: 'CN', child: Text('中国')),
                      DropdownMenuItem(value: 'US', child: Text('美国')),
                      DropdownMenuItem(value: 'JP', child: Text('日本')),
                    ],
                    onChanged: (value) {
                      // TODO: 实现地区切换逻辑
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
