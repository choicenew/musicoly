import 'package:flutter/material.dart';

class DesktopSettings extends StatelessWidget {
  const DesktopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('开机自启动'),
              subtitle: const Text('系统启动时自动运行应用'),
              value: false,
              onChanged: (value) {
                // TODO: 实现开机自启动设置
              },
            ),
            SwitchListTile(
              title: const Text('最小化到系统托盘'),
              subtitle: const Text('关闭窗口时最小化到系统托盘而不是退出'),
              value: true,
              onChanged: (value) {
                // TODO: 实现最小化到系统托盘设置
              },
            ),
            SwitchListTile(
              title: const Text('媒体键控制'),
              subtitle: const Text('使用键盘媒体键控制播放'),
              value: true,
              onChanged: (value) {
                // TODO: 实现媒体键控制设置
              },
            ),
            SwitchListTile(
              title: const Text('系统通知'),
              subtitle: const Text('显示歌曲切换等系统通知'),
              value: true,
              onChanged: (value) {
                // TODO: 实现系统通知设置
              },
            ),
            ListTile(
              title: const Text('快捷键设置'),
              subtitle: const Text('自定义全局快捷键'),
              trailing: TextButton(
                onPressed: () {
                  // TODO: 实现快捷键设置
                },
                child: const Text('设置'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
