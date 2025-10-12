// ========================================
// 2. CONFIG
// ========================================

// lib/core/config/app_config.dart
class AppConfig {
  final String appName;
  final String baseUrl;
  final bool debugMode;
  final String environment;

  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.debugMode,
    required this.environment,
  });

  static AppConfig? _instance;

  static AppConfig get instance {
    assert(_instance != null, '⚠️ AppConfig chưa được khởi tạo');
    return _instance!;
  }

  static void initialize({
    required String appName,
    required String baseUrl,
    required bool debugMode,
    required String environment,
  }) {
    _instance = AppConfig(
      appName: appName,
      baseUrl: baseUrl,
      debugMode: debugMode,
      environment: environment,
    );
  }
}
