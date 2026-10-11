import 'package:flutter/material.dart';

enum SlideDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }

class SlidePageTransition<T> extends PageRouteBuilder<T> {
  SlidePageTransition({
    required Widget page,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    SlideDirection direction = SlideDirection.rightToLeft,
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

           late final Offset begin;
           switch (direction) {
             case SlideDirection.leftToRight:
               begin = const Offset(-1, 0);
               break;
             case SlideDirection.rightToLeft:
               begin = const Offset(1, 0);
               break;
             case SlideDirection.topToBottom:
               begin = const Offset(0, -1);
               break;
             case SlideDirection.bottomToTop:
               begin = const Offset(0, 1);
               break;
           }

           return SlideTransition(
             position: Tween<Offset>(
               begin: begin,
               end: Offset.zero,
             ).chain(CurveTween(curve: curve)).animate(curvedAnimation),
             child: child,
           );
         },
       );
}
