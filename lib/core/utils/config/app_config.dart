// lib/core/config/app_config.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';

enum AppEnvironment { development, staging, production }

class AppConfig {
  final String appName;
  final String baseUrl;
  final AppEnvironment environment;
  final bool debugMode;

  static AppConfig? _instance;

  AppConfig._({
    required this.appName,
    required this.baseUrl,
    required this.environment,
    required this.debugMode,
  });

  /// Khởi tạo cấu hình
  static void initialize(AppEnvironment env) {
    _instance = AppConfig._(
      appName: _appNameFor(env),
      baseUrl: _baseUrlFor(env),
      environment: env,
      debugMode: kDebugMode,
    );
  }

  static AppConfig get instance {
    assert(_instance != null, '⚠️ AppConfig chưa được khởi tạo');
    return _instance!;
  }

  // Helpers
  static String _appNameFor(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.development:
        return "My Flutter App (Dev)";
      case AppEnvironment.staging:
        return "My Flutter App (Staging)";
      case AppEnvironment.production:
        return "My Flutter App";
    }
  }

  static String _baseUrlFor(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.development:
        return ApiConstants.baseUrlDev;
      case AppEnvironment.staging:
        return ApiConstants.baseUrlStaging;
      case AppEnvironment.production:
        return ApiConstants.baseUrlProd;
    }
  }

  // Tiện ích nhanh
  static bool get isDev => instance.environment == AppEnvironment.development;
  static bool get isStaging => instance.environment == AppEnvironment.staging;
  static bool get isProd => instance.environment == AppEnvironment.production;
}
