import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'Gravity Flip';
  static const String appTagline = 'Gravity rewritten';
  static const String packageName = 'com.gravityflip.game';
  static const String supportEmail = 'support@gravityflipgame.com';
  static const String privacyPolicyUrl = 'https://gravityflipgame.com/privacy';
  static const String termsUrl = 'https://gravityflipgame.com/terms';

  static const Duration splashDelay = Duration(milliseconds: 1800);
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 350);
  static const Duration animationLong = Duration(milliseconds: 600);

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1100;
  static const double maxCanvasWidth = 1280;
  static const double defaultPadding = 16;
  static const double defaultRadius = 20;

  static const List<String> supportedLocales = ['en', 'es', 'fr'];
  static const String defaultLocale = 'en';

  static const EdgeInsets defaultPaddingAll = EdgeInsets.all(defaultPadding);
  static const EdgeInsets defaultHorizontalPadding = EdgeInsets.symmetric(
    horizontal: defaultPadding,
  );
  static const EdgeInsets defaultVerticalPadding = EdgeInsets.symmetric(
    vertical: defaultPadding,
  );

  static const Map<String, dynamic> defaultSettings = {
    'soundEnabled': true,
    'musicEnabled': true,
    'vibrationEnabled': true,
    'showTutorial': true,
    'highContrast': false,
  };
}
