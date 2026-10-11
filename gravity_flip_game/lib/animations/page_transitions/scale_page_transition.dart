import 'package:flutter/material.dart';

class ScalePageTransition<T> extends PageRouteBuilder<T> {
  ScalePageTransition({
    required Widget page,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutBack,
    Alignment alignment = Alignment.center,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final curvedAnimation = CurvedAnimation(
             parent: animation,
             curve: curve,
             reverseCurve: Curves.easeInBack,
           );

           return ScaleTransition(
             scale: Tween<double>(
               begin: 0.9,
               end: 1.0,
             ).chain(CurveTween(curve: curve)).animate(curvedAnimation),
             alignment: alignment,
             child: child,
           );
         },
       );
}
