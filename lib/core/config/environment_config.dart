// lib/core/config/environment_config.dart
import 'package:flutter_base_template/core/constants/api_constants.dart';

enum Environment {
  development,
  staging,
  production,
}

class EnvironmentConfig {
  static Environment _currentEnvironment = Environment.development;
  
  static Environment get current => _currentEnvironment;
  
  static void setEnvironment(Environment env) {
    _currentEnvironment = env;
  }
  
  static bool get isDevelopment => _currentEnvironment == Environment.development;
  static bool get isStaging => _currentEnvironment == Environment.staging;
  static bool get isProduction => _currentEnvironment == Environment.production;
  
  static String get baseUrl {
    switch (_currentEnvironment) {
      case Environment.development:
        return ApiConstants.baseUrlDev;
      case Environment.staging:
        return ApiConstants.baseUrlStaging;
      case Environment.production:
        return ApiConstants.baseUrlProd;
    }
  }
}