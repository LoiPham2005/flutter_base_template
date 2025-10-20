// lib/core/config/app_initializer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/l10n/localization_service.dart';
import 'package:flutter_base_template/core/theme/theme_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppInitializer {
  static Future<void> initialize({required String flavor}) async {
    // 🔹 Logger
    Logger.configure(enabled: true, minLevel: LogLevel.debug);

    // 🔹 UI / Orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // 🔹 Setup DI với flavor tương ứng
    await configureDependencies(flavor: flavor);

    // 🔹 Khởi tạo các service sau khi DI đã sẵn sàng
    await getIt<ThemeService>().initTheme();
    await getIt<LocalizationService>().initLocale();

    Logger.info('✅ App initialized successfully for flavor: $flavor');
  }
}
