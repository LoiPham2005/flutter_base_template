import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:flutter_base_template/env/env_dev.dart';
import 'package:flutter_base_template/env/env_staging.dart';
import 'package:flutter_base_template/env/env_prod.dart';

enum Environment { development, staging, production }

class EnvironmentConfig {
  EnvironmentConfig._();

  // ════════════════════════════════════════════════════════════════
  // CURRENT ENVIRONMENT (Set ở main_*.dart)
  // ════════════════════════════════════════════════════════════════
  static Environment _current = Environment.development;

  static void setEnvironment(Environment env) {
    _current = env;
  }

  static Environment get environment => _current;

  // ════════════════════════════════════════════════════════════════
  // HELPERS
  // ════════════════════════════════════════════════════════════════
  static bool get isDev => _current == Environment.development;
  static bool get isStaging => _current == Environment.staging;
  static bool get isProduction => _current == Environment.production;

  // ════════════════════════════════════════════════════════════════
  // API CONFIGURATION (Từ Envied)
  // ════════════════════════════════════════════════════════════════
  static String get apiBaseUrl {
    switch (_current) {
      case Environment.development:
        return EnvDev.apiBaseUrl;
      case Environment.staging:
        return EnvStaging.apiBaseUrl;
      case Environment.production:
        return EnvProd.apiBaseUrl;
    }
  }

  static String get webSocketUrl {
    switch (_current) {
      case Environment.development:
        return EnvDev.wsUrl;
      case Environment.staging:
        return EnvStaging.wsUrl;
      case Environment.production:
        return EnvProd.wsUrl;
    }
  }

  // ════════════════════════════════════════════════════════════════
  // FEATURE FLAGS (Từ Envied)
  // ════════════════════════════════════════════════════════════════
  static bool get enableLogging {
    switch (_current) {
      case Environment.development:
        return EnvDev.enableLogging;
      case Environment.staging:
        return EnvStaging.enableLogging;
      case Environment.production:
        return EnvProd.enableLogging;
    }
  }

  static bool get enableDebugTools {
    switch (_current) {
      case Environment.development:
        return EnvDev.enableDebugTools;
      case Environment.staging:
        return EnvStaging.enableDebugTools;
      case Environment.production:
        return EnvProd.enableDebugTools;
    }
  }

  static bool get enableAnalytics {
    switch (_current) {
      case Environment.development:
        return EnvDev.enableAnalytics;
      case Environment.staging:
        return EnvStaging.enableAnalytics;
      case Environment.production:
        return EnvProd.enableAnalytics;
    }
  }

  static bool get enableCrashReporting => isProduction || isStaging;

  // ════════════════════════════════════════════════════════════════
  // TIMEOUT CONFIGURATION (Từ Envied)
  // ════════════════════════════════════════════════════════════════
  static Duration get connectTimeout {
    final seconds = switch (_current) {
      Environment.development => EnvDev.connectTimeout,
      Environment.staging => EnvStaging.connectTimeout,
      Environment.production => EnvProd.connectTimeout,
    };
    return Duration(seconds: seconds);
  }

  static Duration get receiveTimeout {
    final seconds = switch (_current) {
      Environment.development => EnvDev.receiveTimeout,
      Environment.staging => EnvStaging.receiveTimeout,
      Environment.production => EnvProd.receiveTimeout,
    };
    return Duration(seconds: seconds);
  }

  // ════════════════════════════════════════════════════════════════
  // API KEYS (Từ Envied, đã obfuscate)
  // ════════════════════════════════════════════════════════════════
  static String get googleMapsApiKey {
    switch (_current) {
      case Environment.development:
        return EnvDev.googleMapsApiKey;
      case Environment.staging:
        return EnvStaging.googleMapsApiKey;
      case Environment.production:
        return EnvProd.googleMapsApiKey;
    }
  }

  static String get stripePublicKey {
    switch (_current) {
      case Environment.development:
        return EnvDev.stripePublicKey;
      case Environment.staging:
        return EnvStaging.stripePublicKey;
      case Environment.production:
        return EnvProd.stripePublicKey;
    }
  }

  // ════════════════════════════════════════════════════════════════
  // APP INFO (Flavorizr quản lý thực tế)
  // ════════════════════════════════════════════════════════════════
  static String get appName {
    switch (_current) {
      case Environment.development:
        return 'MyApp Dev';
      case Environment.staging:
        return 'MyApp Staging';
      case Environment.production:
        return 'MyApp';
    }
  }

  static String get bundleId {
    switch (_current) {
      case Environment.development:
        return 'com.yourapp.dev';
      case Environment.staging:
        return 'com.yourapp.staging';
      case Environment.production:
        return 'com.yourapp';
    }
  }

  // ════════════════════════════════════════════════════════════════
  // OTHER CONFIG
  // ════════════════════════════════════════════════════════════════
  static int get maxRetries => isDev ? 1 : 3;

  static String get storagePrefix {
    switch (_current) {
      case Environment.development:
        return 'dev_';
      case Environment.staging:
        return 'stg_';
      case Environment.production:
        return '';
    }
  }

  // ════════════════════════════════════════════════════════════════
  // PRINT INFO
  // ════════════════════════════════════════════════════════════════
  static void printInfo() {
    const borderWidth = 60;
    String pad(String text) => text.padRight(borderWidth - 2);

    final buffer = StringBuffer();
    buffer.writeln('╔${'═' * (borderWidth - 1)}');
    buffer.writeln('║ ${pad('🌍 ENVIRONMENT INFO')}');
    buffer.writeln('╠${'═' * (borderWidth - 1)}');
    buffer.writeln('║ ${pad('Environment: ${_current.name.toUpperCase()}')}');
    buffer.writeln('║ ${pad('API Base URL: $apiBaseUrl')}');
    buffer.writeln('║ ${pad('WebSocket URL: $webSocketUrl')}');
    buffer.writeln('║ ${pad('App Name: $appName')}');
    buffer.writeln('║ ${pad('Bundle ID: $bundleId')}');
    buffer.writeln('║ ${pad('Logging: ${enableLogging ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Debug Tools: ${enableDebugTools ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Analytics: ${enableAnalytics ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Crash Reporting: ${enableCrashReporting ? "✅" : "❌"}')}');
    buffer.writeln('╚${'═' * (borderWidth - 1)}');

    Logger.info('\n${buffer.toString()}', tag: 'ENV');
  }

  static Map<String, dynamic> toJson() {
    return {
      'environment': _current.name,
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
