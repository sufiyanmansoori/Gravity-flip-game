import 'package:flutter/material.dart';

import 'core/config/app_config.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'services/ad_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appDisplayName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

class GravityFlipApp extends StatefulWidget {
  const GravityFlipApp({super.key});

  @override
  State<GravityFlipApp> createState() => _GravityFlipAppState();
}

class _GravityFlipAppState extends State<GravityFlipApp> {
  late final ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    _themeProvider = ServiceLocator.instance.get<ThemeProvider>();
    _themeProvider.addListener(_handleThemeChanged);
  }

  @override
  void dispose() {
    _themeProvider.removeListener(_handleThemeChanged);
    super.dispose();
  }

  void _handleThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final appConfig = ServiceLocator.instance.get<AppConfig>();

    return MaterialApp(
      title: AppConfig.appDisplayName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeProvider.themeMode,
      navigatorKey: appConfig.navigatorKey,
      home: const SplashScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(appConfig.textScaleFactor)),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.initialize();
  await AdService.initialize();

  runApp(const MyApp());
}
