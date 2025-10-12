// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../storage/local_storage.dart';
import '../../utils/logger.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage = LocalStorage();
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from storage
    final token = await _localStorage.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      Logger.debug('Added token to request: ${options.path}');
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      Logger.warning('Token expired or invalid');
      
      // Try to refresh token
      final refreshed = await _refreshToken();
      
      if (refreshed) {
        // Retry request with new token
        try {
          final response = await _retry(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          Logger.error('Retry failed', error: e);
        }
      }
      
      // Clear token and redirect to login
      await _localStorage.clearToken();
      // TODO: Navigate to login screen
    }
    
    handler.next(err);
  }
  
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _localStorage.getRefreshToken();
      if (refreshToken == null) return false;
      
      // TODO: Implement refresh token logic
      // final response = await dio.post('/auth/refresh', data: {
      //   'refresh_token': refreshToken,
      // });
      
      // Save new token
      // await _localStorage.saveToken(response.data['access_token']);
      
      return true;
    } catch (e) {
      Logger.error('Refresh token failed', error: e);
      return false;
    }
  }
  
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    
    return Dio().request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
