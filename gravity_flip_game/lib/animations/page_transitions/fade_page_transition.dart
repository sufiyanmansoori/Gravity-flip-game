import 'package:flutter/material.dart';

class FadePageTransition<T> extends PageRouteBuilder<T> {
  FadePageTransition({
    required Widget page,
    Duration duration = const Duration(milliseconds: 350),
    Curve curve = Curves.easeOutCubic,
    super.settings,
    super.opaque,
    super.fullscreenDialog,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final curvedAnimation = CurvedAnimation(
             parent: animation,
             curve: curve,
             reverseCurve: Curves.easeInCubic,
           );

           return FadeTransition(opacity: curvedAnimation, child: child);
         },
       );
}
