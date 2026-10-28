import 'package:flutter/material.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// 欢迎部分组件
class GreetingSection extends StatelessWidget {
  /// 构造函数
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.welcome_to_pyro_music,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.let_us_configure_first,
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
