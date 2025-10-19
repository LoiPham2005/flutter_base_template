import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/app/app_observer.dart';
import 'package:flutter_base_template/core/config/app_config.dart';
import 'package:flutter_base_template/core/l10n/app_localization_delegate_config.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';

import '../../router/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _observer = AppObserver();

  @override
  void initState() {
    super.initState();
    _observer.initialize();
  }

  @override
  void dispose() {
    _observer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.instance.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

     // Localization
      locale: AppLocalizationConfig.defaultLocale,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,

      // router
      routerConfig: AppRouter.router,

    );
  }
}
