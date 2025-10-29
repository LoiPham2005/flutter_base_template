// ════════════════════════════════════════════════════════════════
// 📁 lib/core/config/environment_config.dart (TỐI ƯU LOGGER)
// ════════════════════════════════════════════════════════════════
import 'package:flutter/foundation.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';

enum Environment { development, staging, production }

class EnvironmentConfig {
  static const String _envString = String.fromEnvironment('ENV', defaultValue: 'dev');

  static Environment get environment {
    switch (_envString.toLowerCase()) {
      case 'dev':
      case 'development':
        return Environment.development;
      case 'stg':
      case 'staging':
        return Environment.staging;
      case 'prod':
      case 'production':
        return Environment.production;
      default:
        return Environment.development;
    }
  }

  static bool get isDev => environment == Environment.development;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.production;

  static String get apiBaseUrl {
    switch (environment) {
      case Environment.development:
        return ApiConstants.baseUrlDev;
      case Environment.staging:
        return ApiConstants.baseUrlStaging;
      case Environment.production:
        return ApiConstants.baseUrlProd;
    }
  }

  static String get webSocketUrl {
    switch (environment) {
      case Environment.development:
        return 'wss://ws-dev.yourapp.com';
      case Environment.staging:
        return 'wss://ws-staging.yourapp.com';
      case Environment.production:
        return 'wss://ws.yourapp.com';
    }
  }

  static String get appName {
    switch (environment) {
      case Environment.development:
        return 'MyApp Dev';
      case Environment.staging:
        return 'MyApp Staging';
      case Environment.production:
        return 'MyApp';
    }
  }

  static String get bundleId {
    switch (environment) {
      case Environment.development:
        return 'com.yourapp.dev';
      case Environment.staging:
        return 'com.yourapp.staging';
      case Environment.production:
        return 'com.yourapp';
    }
  }

  static bool get enableLogging => !isProduction;
  static bool get enableDebugTools => isDev;
  static bool get enableAnalytics => isProduction || isStaging;
  static bool get enableCrashReporting => isProduction || isStaging;

  static Duration get connectTimeout {
    return isDev ? const Duration(seconds: 60) : const Duration(seconds: 30);
  }

  static Duration get receiveTimeout {
    return isDev ? const Duration(seconds: 60) : const Duration(seconds: 30);
  }

  static int get maxRetries => isDev ? 1 : 3;

  static String get storagePrefix {
    switch (environment) {
      case Environment.development:
        return 'dev_';
      case Environment.staging:
        return 'stg_';
      case Environment.production:
        return '';
    }
  }

  static String get firebaseOptionsPath {
    switch (environment) {
      case Environment.development:
        return 'lib/firebase_options_dev.dart';
      case Environment.staging:
        return 'lib/firebase_options_staging.dart';
      case Environment.production:
        return 'lib/firebase_options.dart';
    }
  }

  // ✅ TỐI ƯU: Gọn hơn, đẹp hơn
  static void printInfo() {
    if (!kDebugMode) return; // ✅ CHỈ print ở debug mode

    print('╔═══════════════════════════════════════════════════════════');
    print('║ 🌍 ${environment.name.toUpperCase()} | $apiBaseUrl');
    print('╚═══════════════════════════════════════════════════════════');
    
    // ✅ CHỈ 3 dòng thay vì 10 dòng!
  }

  static Map<String, dynamic> toJson() {
    return {
      'environment': environment.name,
      'apiBaseUrl': apiBaseUrl,
      'webSocketUrl': webSocketUrl,
      'appName': appName,
      'bundleId': bundleId,
      'enableLogging': enableLogging,
      'enableDebugTools': enableDebugTools,
      'enableAnalytics': enableAnalytics,
      'enableCrashReporting': enableCrashReporting,
      'connectTimeout': connectTimeout.inSeconds,
      'receiveTimeout': receiveTimeout.inSeconds,
    };
  }
}