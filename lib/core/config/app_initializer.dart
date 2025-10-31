// ════════════════════════════════════════════════════════════════
// 📁 lib/core/config/app_initializer.dart (TỐI ƯU LOGGER)
// ════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/core/config/app_observer.dart';
import 'package:flutter_base_template/core/config/app_bloc_observer.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/theme/theme_cubit.dart';
import 'package:flutter_base_template/core/l10n/localization_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:flutter_base_template/core/utils/logger_config.dart'; // ✅ Import

class AppInitializer {
  AppInitializer._();

  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final stopwatch = Stopwatch()..start();

      EnvironmentConfig.printInfo();
      
      LoggerConfig.configure();
      
      await _configureUI();
      AppObserver().initialize();
      _configureBlocObserver();
      await configureDependencies();
      await _initializeServices();

      stopwatch.stop();
      _isInitialized = true;

      if (EnvironmentConfig.isDev) {
        Logger.success('✅ App initialized in ${stopwatch.elapsedMilliseconds}ms');
      }
    } catch (e, stackTrace) {
      Logger.error('❌ Failed to initialize app', error: e, stackTrace: stackTrace);
      await _cleanup();
      rethrow;
    }
  }

  static Future<void> _cleanup() async {
    try {
      AppObserver().dispose();
      await resetDependencies();
      _isInitialized = false;
    } catch (e) {
      if (EnvironmentConfig.isDev) {
        Logger.warning('⚠️ Cleanup error: $e');
      }
    }
  }

  static Future<void> _configureUI() async {
    try {
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
    } catch (e) {
      Logger.warning('⚠️ UI configuration warning: $e');
    }
  }

  static void _configureBlocObserver() {
    if (EnvironmentConfig.isDev || EnvironmentConfig.isStaging) {
      Bloc.observer = AppBlocObserver();
    }
  }

  static Future<void> _initializeServices() async {
    try {
      await getIt<ThemeCubit>().initTheme();
      await getIt<LocaleCubit>().initLocale();
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize services', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
