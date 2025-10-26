// ════════════════════════════════════════════════════════════════
// 📁 lib/core/network/interceptors/auth_interceptor.dart
// ════════════════════════════════════════════════════════════════
import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/services/auth_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storageService);
  final StorageService _storageService;
  final authService = getIt<AuthService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip token cho các API public
    if (_isPublicApi(options.path)) {
      return handler.next(options);
    }

    // Thêm token vào header
    final token = _storageService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      Logger.warning('No token for: ${options.path}'); // ✅ Log ngắn gọn
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    Logger.info('Token expired (401). Refreshing...'); // ✅ Log ngắn gọn

    try {
      final success = await authService.refreshToken();

      if (!success) {
        Logger.warning('Refresh failed. Logging out.'); // ✅ Log ngắn gọn
        await authService.logout();
        return handler.reject(err);
      }

      Logger.info('Refresh success. Retrying request.'); // ✅ Log ngắn gọn
      final response = await _retryRequest(err.requestOptions);
      return handler.resolve(response);
    } catch (e) {
      Logger.error('Token refresh error', error: e); // ✅ Format đẹp
      await getIt<AuthService>().logout();
      return handler.reject(err);
    }
  }

  // 🔒 Danh sách API không cần auth
  /// Kiểm tra xem API có phải public không
  bool _isPublicApi(String path) {
    return ApiConstants.publicEndpoints.any(
      (publicPath) => path.contains(publicPath),
    );
  }

  /// Retry request với token mới
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final token = _storageService.getToken();

    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $token'},
    );

    // Tạo Dio instance mới để tránh trigger interceptor lại
    final dio = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        connectTimeout: requestOptions.connectTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
      ),
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
