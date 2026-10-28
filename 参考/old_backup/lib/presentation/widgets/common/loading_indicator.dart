import 'package:flutter/material.dart';

/// A reusable loading indicator widget that can be used throughout the app
class LoadingIndicator extends StatelessWidget {
  /// The size of the loading indicator
  final double size;

  /// The stroke width of the circular progress indicator
  final double strokeWidth;

  /// The color of the loading indicator. If null, uses the primary color from the theme
  final Color? color;

  /// Optional text to display below the loading indicator
  final String? text;

  /// Whether to center the loading indicator in its parent
  final bool center;

  const LoadingIndicator({
    Key? key,
    this.size = 40.0,
    this.strokeWidth = 4.0,
    this.color,
    this.text,
    this.center = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = color ?? theme.colorScheme.primary;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
          ),
        ),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (center) {
      content = Center(child: content);
    }

    return content;
  }
}
