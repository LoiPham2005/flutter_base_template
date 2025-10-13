import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  EnvConfig._();
  
  static Future<void> load({String? fileName}) async {
    await dotenv.load(fileName: fileName ?? '.env.development');
  }
  
  // App
  static String get appName => dotenv.get('APP_NAME', fallback: 'My App');
  static String get environment => dotenv.get('ENVIRONMENT', fallback: 'development');
  
  // API
  static String get apiBaseUrl => dotenv.get('API_BASE_URL', fallback: '');
  static String get apiKey => dotenv.get('API_KEY', fallback: '');
  static String get apiSecret => dotenv.get('API_SECRET', fallback: '');
  static int get apiTimeout => int.tryParse(dotenv.get('API_TIMEOUT', fallback: '30000')) ?? 30000;
  
  // Features
  static bool get enableLogging => dotenv.get('ENABLE_LOGGING', fallback: 'false').toLowerCase() == 'true';
  static bool get enableAnalytics => dotenv.get('ENABLE_ANALYTICS', fallback: 'false').toLowerCase() == 'true';
  
  // Third-party
  static String get sentryDsn => dotenv.get('SENTRY_DSN', fallback: '');
  static String get googleMapsApiKey => dotenv.get('GOOGLE_MAPS_API_KEY', fallback: '');
}