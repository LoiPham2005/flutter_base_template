import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';
import 'package:flutter_base_template/core/l10n/app_localization_delegate_config.dart';
import 'package:flutter_base_template/core/services/navigation_service.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Base App',
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Localization
      locale: AppLocalizationConfig.defaultLocale,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,

      navigatorKey: NavigationService().navigatorKey,

      // Chỉ định màn đầu tiên
      home: const HomePage(),
    );
  }
}
