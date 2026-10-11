import 'package:flutter/material.dart';

class AppConfig {
  AppConfig({
    this.appName = 'Gravity Flip',
    this.version = '1.0.0',
    this.debugMode = false,
    this.textScaleFactor = 1.0,
    this.isProduction = true,
    GlobalKey<NavigatorState>? navigatorKey,
  }) : navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  final String appName;
  final String version;
  final bool debugMode;
  final double textScaleFactor;
  final bool isProduction;
  final GlobalKey<NavigatorState> navigatorKey;

  static const String appDisplayName = 'Gravity Flip';

  AppConfig copyWith({
    String? appName,
    String? version,
    bool? debugMode,
    double? textScaleFactor,
    bool? isProduction,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      version: version ?? this.version,
      debugMode: debugMode ?? this.debugMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      isProduction: isProduction ?? this.isProduction,
      navigatorKey: navigatorKey ?? this.navigatorKey,
    );
  }
}
