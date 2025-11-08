import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:flutter_base_template/env/env_dev.dart';
import 'package:flutter_base_template/env/env_prod.dart';
import 'package:flutter_base_template/env/env_staging.dart';

enum Environment { development, staging, production }

class EnvironmentConfig {
  EnvironmentConfig._();

  // ════════════════════════════════════════════════════════════════
  // CURRENT ENVIRONMENT
  // ════════════════════════════════════════════════════════════════
  static Environment _current = Environment.development;

  static void setEnvironment(Environment env) => _current = env;

  static Environment get environment => _current;

  // ════════════════════════════════════════════════════════════════
  // HELPERS
  // ════════════════════════════════════════════════════════════════
  static bool get isDev => _current == Environment.development;
  static bool get isStaging => _current == Environment.staging;
  static bool get isProduction => _current == Environment.production;

  // ════════════════════════════════════════════════════════════════
  // API CONFIGURATION (từ Envied)
  // ════════════════════════════════════════════════════════════════
  static String get apiBaseUrl => switch (_current) {
    Environment.development => EnvDev.apiBaseUrl,
    Environment.staging => EnvStaging.apiBaseUrl,
    Environment.production => EnvProd.apiBaseUrl,
  };

  static String get webSocketUrl => switch (_current) {
    Environment.development => EnvDev.wsUrl,
    Environment.staging => EnvStaging.wsUrl,
    Environment.production => EnvProd.wsUrl,
  };

  // ════════════════════════════════════════════════════════════════
  // FEATURE FLAGS
  // ════════════════════════════════════════════════════════════════
  static bool get enableLogging => switch (_current) {
    Environment.development => EnvDev.enableLogging,
    Environment.staging => EnvStaging.enableLogging,
    Environment.production => EnvProd.enableLogging,
  };

  static bool get enableDebugTools => switch (_current) {
    Environment.development => EnvDev.enableDebugTools,
    Environment.staging => EnvStaging.enableDebugTools,
    Environment.production => EnvProd.enableDebugTools,
  };

  static bool get enableAnalytics => switch (_current) {
    Environment.development => EnvDev.enableAnalytics,
    Environment.staging => EnvStaging.enableAnalytics,
    Environment.production => EnvProd.enableAnalytics,
  };

  static bool get enableCrashReporting => isProduction || isStaging;

  // ════════════════════════════════════════════════════════════════
  // TIMEOUT CONFIGURATION
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
  // API KEYS (obfuscate)
  // ════════════════════════════════════════════════════════════════
  static String get googleMapsApiKey => switch (_current) {
    Environment.development => EnvDev.googleMapsApiKey,
    Environment.staging => EnvStaging.googleMapsApiKey,
    Environment.production => EnvProd.googleMapsApiKey,
  };

  static String get stripePublicKey => switch (_current) {
    Environment.development => EnvDev.stripePublicKey,
    Environment.staging => EnvStaging.stripePublicKey,
    Environment.production => EnvProd.stripePublicKey,
  };

  // ════════════════════════════════════════════════════════════════
  // PRINT INFO (Debug)
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
    buffer.writeln('║ ${pad('Logging: ${enableLogging ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Debug Tools: ${enableDebugTools ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Analytics: ${enableAnalytics ? "✅" : "❌"}')}');
    buffer.writeln('║ ${pad('Crash Reporting: ${enableCrashReporting ? "✅" : "❌"}')}');
    buffer.writeln('╚${'═' * (borderWidth - 1)}');

    Logger.info('\n${buffer.toString()}', tag: 'ENV');
  }
}
