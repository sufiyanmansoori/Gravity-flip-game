import 'package:flutter/material.dart';

class AnimationUtils {
  AnimationUtils._();

  static CurvedAnimation fadeAnimation(
    TickerProvider vsync, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CurvedAnimation(
      parent: AnimationController(vsync: vsync, duration: duration),
      curve: Curves.easeOutCubic,
    );
  }

  static Tween<double> scaleTween({double begin = 0.9, double end = 1.0}) {
    return Tween<double>(begin: begin, end: end);
  }

  static Tween<Offset> slideTween({
    Offset begin = const Offset(0, 0.1),
    Offset end = Offset.zero,
  }) {
    return Tween<Offset>(begin: begin, end: end);
  }

  static DecorationTween glowDecoration({
    required Color color,
    BorderRadius radius = const BorderRadius.all(Radius.circular(24)),
  }) {
    return DecorationTween(
      begin: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      end: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
