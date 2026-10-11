import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 14,
    this.elevation = 0,
    this.padding,
    this.textStyle,
    this.disabled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = (disabled || isLoading) ? null : onPressed;

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                foregroundColor ?? theme.colorScheme.onPrimary,
              ),
            ),
          )
        else if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        if (!isLoading)
          Text(
            label,
            textAlign: TextAlign.center,
            style:
                textStyle ??
                theme.textTheme.labelLarge?.copyWith(
                  color: foregroundColor ?? theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          )
        else
          Text(
            'Loading...',
            style:
                textStyle ??
                theme.textTheme.labelLarge?.copyWith(
                  color: foregroundColor ?? theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 18),
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
