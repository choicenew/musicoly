import 'package:flutter/material.dart';

/// A widget that displays a welcome header on the home page
class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final greeting = _getGreeting();
    final username = 'User'; // This would come from auth provider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome back, $username',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.textTheme.titleMedium?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  /// Returns a greeting based on the current time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
