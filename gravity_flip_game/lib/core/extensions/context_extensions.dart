import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get width => screenSize.width;
  double get height => screenSize.height;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1100;
  bool get isDesktop => width >= 1100;

  void unFocus() => FocusScope.of(this).unfocus();

  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute<T>(builder: (_) => page));
  }
}
