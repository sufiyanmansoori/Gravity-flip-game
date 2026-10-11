import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 48,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius = 16,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = Material(
      color: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Icon(
            icon,
            size: size / 2,
            color: foregroundColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ),
    );

    if (tooltip == null) {
      return SizedBox(width: size, height: size, child: button);
    }

    return Tooltip(
      message: tooltip!,
      child: SizedBox(width: size, height: size, child: button),
    );
  }
}
