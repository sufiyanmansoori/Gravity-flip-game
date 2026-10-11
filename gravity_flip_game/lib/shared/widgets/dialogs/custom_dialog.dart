import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.icon,
    this.constraints,
    this.contentPadding,
    this.scrollable = false,
  });

  final String title;
  final Widget content;
  final List<Widget>? actions;
  final IconData? icon;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? contentPadding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: ConstrainedBox(
        constraints: constraints ?? const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 8),
                  physics: scrollable
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  child: content,
                ),
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(spacing: 8, runSpacing: 8, children: actions!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
