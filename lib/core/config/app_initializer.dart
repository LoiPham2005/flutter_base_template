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
import 'package:flutter_base_template/core/utils/logger_config.dart';

class AppInitializer {
  // Private constructor to prevent instantiation
  AppInitializer._();

  // Indicates whether the app has been initialized
  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  /// ✅ Khởi tạo app
  /// Main entry point for initializing the application
  static Future<void> initialize() async {
    // Prevent re-initialization if already initialized
    if (_isInitialized) return;

    try {
      // Create a Stopwatch instance and start it immediately to measure initialization time
      final stopwatch = Stopwatch()..start();

      // Print environment information
      EnvironmentConfig.printInfo();
      // Configure the logger
      LoggerConfig.configure();

      // Configure UI settings (orientation, system overlays)
      await _configureUI();
      // Initialize global app observer
      AppObserver().initialize();
      // Set up Bloc observer for state management
      _configureBlocObserver();
      // Set up dependency injection
      await configureDependencies();
      // Initialize services such as theme and localization
      await _initializeServices();

      // Stop the stopwatch and log the elapsed time

      stopwatch.stop();
      _isInitialized = true;
      Logger.success('App initialized in ${stopwatch.elapsedMilliseconds}ms');
    } catch (e, stackTrace) {
      // Log and handle initialization errors
      Logger.error(
        '❌ Failed to initialize app',
        error: e,
        stackTrace: stackTrace,
      );
      await _handleInitializationError();
      rethrow;
    }
  }

  /// ✅ Xử lý khi initialization fail
  /// Handles cleanup and reset if initialization fails
  static Future<void> _handleInitializationError() async {
    try {
      // Dispose global observers and reset dependencies
      AppObserver().dispose();
      await resetDependencies();
      _isInitialized = false;
      Logger.warning('⚠️ App reinitialization failed, cleaned up');
    } catch (e) {
      Logger.error('❌ Cleanup error', error: e);
    }
  }

  /// Configure UI orientation and system overlays
  static Future<void> _configureUI() async {
    try {
      // Lock orientation to portrait
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      // Set system UI overlay styles (status bar, navigation bar)
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

  /// Set up Bloc observer for development and staging environments
  static void _configureBlocObserver() {
    if (EnvironmentConfig.isDev || EnvironmentConfig.isStaging) {
      Bloc.observer = AppBlocObserver();
    }
  }

  /// Initialize services such as theme and localization
  static Future<void> _initializeServices() async {
    try {
      await getIt<ThemeCubit>().initTheme();
      await getIt<LocaleCubit>().initLocale();
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to initialize services',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
