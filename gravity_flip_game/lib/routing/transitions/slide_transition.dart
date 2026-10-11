import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> slideTransitionPage<T>({
  required LocalKey key,
  required Widget child,
  Offset begin = const Offset(1, 0),
  Offset end = Offset.zero,
  Duration duration = const Duration(milliseconds: 350),
  Curve curve = Curves.easeOutCubic,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve)).animate(curvedAnimation),
        child: child,
      );
    },
  );
}
