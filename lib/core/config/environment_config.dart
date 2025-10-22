import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';

enum Environment { development, staging, production }

class EnvironmentConfig {
  static Environment _environment = Environment.development;
  
  static Environment get environment => _environment;
  
  static void setEnvironment(Environment env) {
    _environment = env;
  }
  
  static bool get isDev => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;
  
  // API URLs
  static String get apiBaseUrl {
    switch (_environment) {
      case Environment.development:
        return ApiConstants.baseUrlDev;
      case Environment.staging:
        return ApiConstants.baseUrlStaging;
      case Environment.production:
        return ApiConstants.baseUrlProd;
    }
  }
  
  // WebSocket URLs
  static String get webSocketUrl {
    switch (_environment) {
      case Environment.development:
        return 'wss://ws-dev.yourapp.com';
      case Environment.staging:
        return 'wss://ws-staging.yourapp.com';
      case Environment.production:
        return 'wss://ws.yourapp.com';
    }
  }
  
  // App Name
  static String get appName {
    switch (_environment) {
      case Environment.development:
        return AppConstants.appNameDev;
      case Environment.staging:
        return AppConstants.appNameStg;
      case Environment.production:
        return AppConstants.appNameProd;
    }
  }
  
  // Bundle ID / Package Name
  static String get bundleId {
    switch (_environment) {
      case Environment.development:
        return 'com.yourapp.dev';
      case Environment.staging:
        return 'com.yourapp.staging';
      case Environment.production:
        return 'com.yourapp';
    }
  }
  
  // Debug Mode
  static bool get enableLogging {
    return _environment == Environment.development || _environment == Environment.staging;
  }
  
  // API Timeout
  static Duration get apiTimeout {
    return _environment == Environment.development 
        ? const Duration(seconds: 60) 
        : const Duration(seconds: 30);
  }
  
  // Firebase Config (Optional)
  static String get firebaseOptionsPath {
    switch (_environment) {
      case Environment.development:
        return 'lib/firebase_options_dev.dart';
      case Environment.staging:
        return 'lib/firebase_options_staging.dart';
      case Environment.production:
        return 'lib/firebase_options.dart';
    }
  }
}