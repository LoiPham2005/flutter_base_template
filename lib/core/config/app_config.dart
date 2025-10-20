// filepath: lib/core/config/app_config.dart
import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';

enum Environment { development, staging, production }

class AppConfig {
  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.environment,
  });
  final String appName;
  final String baseUrl;
  final Environment environment;

  // Hàm khởi tạo config dựa trên enum
  static AppConfig fromEnvironment(Environment env) {
    switch (env) {
      case Environment.development:
        return AppConfig(
          appName: AppConstants.appNameDev,
          baseUrl: ApiConstants.baseUrlDev,
          environment: env,
        );
      case Environment.staging:
        return AppConfig(
          appName: AppConstants.appNameStg,
          baseUrl: ApiConstants.baseUrlStaging,
          environment: env,
        );
      case Environment.production:
        return AppConfig(
          appName: AppConstants.appNameProd,
          baseUrl: ApiConstants.baseUrlProd,
          environment: env,
        );
    }
  }
}
