// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/check_auth_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthInterceptor extends Interceptor {
  // Nhận StorageService thông qua constructor
  AuthInterceptor(this._storageService);
  final StorageService _storageService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Bỏ qua việc thêm token cho các API không cần xác thực
    final noAuthPaths = [
      '/auth/login',
      '/auth/register',
      '/auth/refresh-token',
    ];
    if (noAuthPaths.any((path) => options.path.contains(path))) {
      return handler.next(options);
    }

    // Lấy token từ StorageService (lưu ý: không có await vì hàm là sync)
    final token = _storageService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      Logger.debug('Added token to request: ${options.path}');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Chỉ xử lý lỗi 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      Logger.warning('Token expired or invalid. Attempting to refresh...');

      try {
        // Lấy service refresh token từ DI
        final checkAuthService = getIt<CheckAuthService>();
        await checkAuthService.checkAndRefreshToken();

        // Sau khi refresh thành công, thử lại request cũ với token mới
        final newRequest = await _retry(err.requestOptions);
        return handler.resolve(newRequest);
      } catch (e) {
        Logger.error('Failed to refresh token or retry request.', error: e);
        // Nếu refresh thất bại, đăng xuất và reject request
        await getIt<CheckAuthService>().logout();
        return handler.reject(err);
      }
    }

    handler.next(err);
  }

  /// Thử lại request với token mới đã được lưu trong StorageService
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final newOptions = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    // Lấy lại token mới nhất từ storage
    final newAuthToken = _storageService.getToken();
    if (newAuthToken != null) {
      newOptions.headers!['Authorization'] = 'Bearer $newAuthToken';
    }

    // Dùng một instance Dio mới để tránh vòng lặp interceptor vô hạn
    return Dio().request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: newOptions,
    );
  }
}
