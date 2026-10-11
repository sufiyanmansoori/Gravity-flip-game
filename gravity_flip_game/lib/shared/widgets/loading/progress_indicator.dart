import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.strokeWidth = 4,
    this.radius = 24,
  });

  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final double strokeWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedColor = color ?? theme.colorScheme.primary;

    if (value == null) {
      return SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(resolvedColor),
          backgroundColor:
              backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
        ),
      );
    }

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(resolvedColor),
        backgroundColor:
            backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
