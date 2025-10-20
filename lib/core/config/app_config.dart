// filepath: lib/core/config/app_config.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';

enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  final String appName;
  final String baseUrl;
  final Environment environment;

  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.environment,
  });

  // Hàm khởi tạo config dựa trên flavor
  static AppConfig fromFlavor(String? flavor) {
    switch (flavor) {
      case 'development':
        return AppConfig(
          appName: 'Base App (Dev)',
          baseUrl: ApiConstants.baseUrlDev,
          environment: Environment.development,
        );
      case 'staging':
        return AppConfig(
          appName: 'Base App (Stg)',
          baseUrl: ApiConstants.baseUrlStaging,
          environment: Environment.staging,
        );
      case 'production':
      default:
        return AppConfig(
          appName: 'Base App',
          baseUrl: ApiConstants.baseUrlProd,
          environment: Environment.production,
        );
    }
  }
}