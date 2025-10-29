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

class AppInitializer {
  AppInitializer._();

  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  static Future<void> initialize() async {
    if (_isInitialized) {
      // ✅ GIẢM: Không log nữa (không xảy ra thường xuyên)
      return;
    }

    try {
      final stopwatch = Stopwatch()..start();

      // Step 1: Print environment info
      EnvironmentConfig.printInfo();

      // Step 2: Configure logger
      _configureLogger();

      // Step 3: Configure UI
      await _configureUI();

      // Step 4: Initialize lifecycle observer
      AppObserver().initialize();

      // Step 5: Configure BlocObserver
      _configureBlocObserver();

      // Step 6: Initialize DI
      await configureDependencies();

      // Step 7: Initialize services
      await _initializeServices();

      stopwatch.stop();
      _isInitialized = true;
      
      // ✅ GIẢM: CHỈ 1 log summary thay vì 3 logs riêng lẻ
      Logger.success(
        '✅ App initialized (${stopwatch.elapsedMilliseconds}ms) | '
        'ENV: ${EnvironmentConfig.environment.name} | '
        'API: ${EnvironmentConfig.apiBaseUrl}'
      );
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
      // ✅ GIẢM: Chỉ log nếu có lỗi thật sự
      if (EnvironmentConfig.isDev) {
        Logger.warning('⚠️ Cleanup error: $e');
      }
    }
  }

  static void _configureLogger() {
    if (EnvironmentConfig.isDev) {
      LogConfig.enableHttpLogs = true;
      LogConfig.enableBlocLogs = true;
      LogConfig.enableDetailedErrors = true;
      LogConfig.enableSuccessLogs = true;
      LogConfig.logOnlyFailedRequests = false;
      LogConfig.maxStackTraceLines = 5;
    } else if (EnvironmentConfig.isStaging) {
      LogConfig.enableHttpLogs = true;
      LogConfig.enableBlocLogs = true;
      LogConfig.enableDetailedErrors = false;
      LogConfig.enableSuccessLogs = false;
      LogConfig.logOnlyFailedRequests = true;
      LogConfig.maxStackTraceLines = 3;
    } else {
      LogConfig.enableHttpLogs = false;
      LogConfig.enableBlocLogs = false;
      LogConfig.enableDetailedErrors = false;
      LogConfig.enableSuccessLogs = false;
      LogConfig.logOnlyFailedRequests = true;
      LogConfig.maxStackTraceLines = 1;
    }
    
    // ✅ GIẢM: Bỏ log này (không cần thiết)
    // Logger.info('Logger configured for ${EnvironmentConfig.environment.name}');
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
      
      // ✅ GIẢM: Bỏ log này (UI config thành công là điều bình thường)
      // Logger.info('UI configured successfully');
    } catch (e) {
      // ✅ GIỮ: Log warning nếu có lỗi (quan trọng)
      Logger.warning('⚠️ UI configuration warning: $e');
    }
  }

  static void _configureBlocObserver() {
    if (EnvironmentConfig.isDev || EnvironmentConfig.isStaging) {
      Bloc.observer = AppBlocObserver();
      // ✅ GIẢM: Bỏ log này (không cần thiết)
      // Logger.info('BlocObserver initialized');
    }
  }

  static Future<void> _initializeServices() async {
    try {
      await getIt<ThemeCubit>().initTheme();
      await getIt<LocaleCubit>().initLocale();
      // ✅ GIẢM: Bỏ log này (thành công là điều bình thường)
      // Logger.info('Services initialized successfully');
    } catch (e, stackTrace) {
      // ✅ GIỮ: Log error (quan trọng)
      Logger.error('Failed to initialize services', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}