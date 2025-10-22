// filepath: lib/core/config/app_initializer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/l10n/localization_service.dart';
import 'package:flutter_base_template/core/theme/theme_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppInitializer {
  static Future<void> initialize() async {
    try {
      // 🔹 Logger
      Logger.configure(enabled: true, minLevel: LogLevel.debug);

      // 🔹 UI / Orientation
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      Logger.info(
        'Initializing app in ${EnvironmentConfig.environment.name} mode',
      );
      Logger.info('API Base URL: ${EnvironmentConfig.apiBaseUrl}');

      // 🔹 Setup DI với enum Environment
      await configureDependencies();

      // 🔹 Khởi tạo các service sau khi DI đã sẵn sàng
      await getIt<ThemeService>().initTheme();
      await getIt<LocaleCubit>().initLocale();

      Logger.success('App initialized successfully');
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to initialize app',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
