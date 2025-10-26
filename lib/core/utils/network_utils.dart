// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/network_utils.dart
// ════════════════════════════════════════════════════════════════
import 'dart:io';

class NetworkUtils {
  NetworkUtils._();

  /// Check internet connectivity
  static Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Parse query parameters from URL
  static Map<String, String> parseQueryParams(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters;
  }

  /// Build URL with query parameters
  static String buildUrl(String baseUrl, Map<String, dynamic> params) {
    final uri = Uri.parse(baseUrl);
    final queryParams = params.map((key, value) => MapEntry(key, value.toString()));
    return uri.replace(queryParameters: queryParams).toString();
  }
}
