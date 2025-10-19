// lib/core/constants/api_constants.dart
class ApiConstants {
  ApiConstants._();

  // Base URLs
  // static const String baseUrlDev = 'https://api-dev.example.com';
  // static const String baseUrlStaging = 'https://api-staging.example.com';
  // static const String baseUrlProd = 'https://api.example.com';

    static const String baseUrl = 'https://api.example.com';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAcceptLanguage = 'Accept-Language';
  
  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/user/profile';
  static const String products = '/products';
  static const String categories = '/categories';

}
