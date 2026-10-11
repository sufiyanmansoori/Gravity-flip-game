import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GameColorScheme {
  GameColorScheme._();

  static ColorScheme light = const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimaryLight,
    error: AppColors.error,
  );

  static ColorScheme dark = const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surfaceDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimaryDark,
    error: AppColors.error,
  );
}
