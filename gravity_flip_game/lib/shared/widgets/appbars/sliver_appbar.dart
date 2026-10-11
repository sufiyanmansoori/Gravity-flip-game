import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.expandedHeight = 180,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.floating = false,
    this.pinned = true,
    this.snap = false,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double expandedHeight;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final bool floating;
  final bool pinned;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      title: title != null ? Text(title!) : null,
      leading: leading,
      actions: actions,
      flexibleSpace: title != null
          ? FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 72,
                bottom: 14,
              ),
              title: Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
      bottom: bottom,
    );
  }
}
