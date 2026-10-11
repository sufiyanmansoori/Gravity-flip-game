import 'package:flutter/material.dart';

class AppColorTween extends Tween<Color> {
  AppColorTween({required Color begin, required Color end})
    : super(begin: begin, end: end);

  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}

class AppGradientTween extends Tween<LinearGradient> {
  AppGradientTween({required LinearGradient begin, required LinearGradient end})
    : super(begin: begin, end: end);

  @override
  LinearGradient lerp(double t) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.lerp(begin?.colors.first, end?.colors.first, t)!,
        Color.lerp(
          begin!.colors.length > 1 ? begin?.colors[1] : begin?.colors.first,
          end!.colors.length > 1 ? end?.colors[1] : end?.colors.first,
          t,
        )!,
      ],
    );
  }
}

class AnimatedGradientBuilder extends StatelessWidget {
  const AnimatedGradientBuilder({
    super.key,
    required this.controller,
    required this.begin,
    required this.end,
    required this.child,
  });

  final AnimationController controller;
  final LinearGradient begin;
  final LinearGradient end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(begin.colors.first, end.colors.first, controller.value)!,
            Color.lerp(
              begin.colors.length > 1 ? begin.colors[1] : begin.colors.first,
              end.colors.length > 1 ? end.colors[1] : end.colors.first,
              controller.value,
            )!,
          ],
        );

        return DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
          child: child,
        );
      },
    );
  }
}
