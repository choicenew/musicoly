import 'package:flutter/material.dart';
import 'package:pyro_music/presentation/pages/getting_started/widgets/greeting_section.dart';
import 'package:pyro_music/presentation/pages/getting_started/widgets/playback_section.dart';
import 'package:pyro_music/presentation/pages/getting_started/widgets/region_section.dart';
import 'package:pyro_music/presentation/pages/getting_started/widgets/support_section.dart';

/// 入门引导页面
class GettingStartedPage extends StatelessWidget {
  /// 构造函数
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingSection(),
              SizedBox(height: 24),
              PlaybackSection(),
              SizedBox(height: 24),
              RegionSection(),
              SizedBox(height: 24),
              SupportSection(),
            ],
          ),
        ),
      ),
    );
  }
}
