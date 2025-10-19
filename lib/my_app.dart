import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/l10n/localization_service.dart';
import 'package:flutter_base_template/core/theme/theme_service.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';
import 'package:flutter_base_template/core/l10n/app_localization_delegate_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final localizationService = getIt<LocalizationService>();

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.currentThemeMode,

      // Localization
      locale: localizationService.currentLocale,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,

      home: const HomePage(),
    );
  }
}
