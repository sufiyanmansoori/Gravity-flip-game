import 'package:flutter/material.dart';

class CustomTweenFactory {
  const CustomTweenFactory._();

  static Animatable<double> createDoubleTween({
    required double begin,
    required double end,
    Curve curve = Curves.easeInOutCubic,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
  }

  static Animatable<Offset> createOffsetTween({
    required Offset begin,
    required Offset end,
    Curve curve = Curves.easeOutCubic,
  }) {
    return Tween<Offset>(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
  }

  static Animatable<Size> createSizeTween({
    required Size begin,
    required Size end,
    Curve curve = Curves.easeInOut,
  }) {
    return Tween<Size>(begin: begin, end: end).chain(CurveTween(curve: curve));
  }

  static TweenSequence<double> createElasticSequence({
    required double begin,
    required double end,
  }) {
    return TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(begin),
        weight: 0.15,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 0.7,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: end,
          end: end + 0.04,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.15,
      ),
    ]);
  }
}

class AnimatedScaleCard extends StatelessWidget {
  const AnimatedScaleCard({
    super.key,
    required this.animation,
    required this.child,
    this.begin = 0.93,
    this.end = 1.0,
  });

  final Animation<double> animation;
  final Widget child;
  final double begin;
  final double end;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final value = Tween<double>(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeOutBack)).evaluate(animation);

        return Transform.scale(scale: value, child: child);
      },
    );
  }
}
