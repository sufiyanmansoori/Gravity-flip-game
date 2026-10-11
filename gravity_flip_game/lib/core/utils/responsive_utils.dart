import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double widthFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 0.85;
    if (width < 600) return 1.0;
    if (width < 900) return 1.2;
    return 1.4;
  }

  static double heightFactor(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (height < 640) return 0.9;
    if (height < 900) return 1.0;
    return 1.1;
  }

  static EdgeInsets responsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return const EdgeInsets.all(12);
    if (width < 768) return const EdgeInsets.all(16);
    return const EdgeInsets.all(24);
  }
}
