import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class DeviceUtils {
  DeviceUtils._();

  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isLinux => Platform.isLinux;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isWindows => Platform.isWindows;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => isLinux || isMacOS || isWindows;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double safePadding(BuildContext context) {
    return MediaQuery.of(context).padding.top + 8;
  }
}
