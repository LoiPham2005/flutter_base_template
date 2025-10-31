// ════════════════════════════════════════════════════════════════
// 📁 lib/core/services/auth_service.dart
// ════════════════════════════════════════════════════════════════
import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  final StorageService _storageService;

  AuthService(this._storageService);

  bool _isRefreshing = false;

  /// Kiểm tra và refresh token nếu cần
  /// Returns: true nếu token còn hợp lệ hoặc refresh thành công
  Future<bool> checkAndRefreshToken() async {
    if (_isRefreshing) {
      Logger.debug('🔄 Refresh đang diễn ra, bỏ qua request mới.');
      return false;
    }

    final accessToken = _storageService.getToken();
    final refreshTokenValue = _storageService.getRefreshToken();

    // Không có token → user chưa login
    if (accessToken == null || refreshTokenValue == null) {
      Logger.debug('🔑 Không có token, bỏ qua kiểm tra.');
      return false;
    }

    try {
      // Kiểm tra refresh token trước
      if (JwtDecoder.isExpired(refreshTokenValue)) {
        Logger.error('⏰ Refresh token hết hạn → Đăng xuất.');
        await logout();
        return false;
      }

      // Access token còn hạn → OK
      if (!JwtDecoder.isExpired(accessToken)) {
        Logger.debug('🔒 Access token vẫn hợp lệ.');
        return true;
      }

      // Access token hết hạn → Refresh
      Logger.info('♻️ Access token hết hạn → Bắt đầu refresh...');
      return await refreshToken();
    } catch (e, stack) {
      Logger.error('💥 Lỗi khi kiểm tra token', error: e, stackTrace: stack);
      await logout();
      return false;
    }
  }

  /// Refresh token
  /// Returns: true nếu refresh thành công
  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      Logger.warning('⚠️ Refresh đang diễn ra, không gọi lại.');
      return false;
    }

    final currentRefreshToken = _storageService.getRefreshToken();
    if (currentRefreshToken == null) {
      Logger.error('❌ Không có refresh token để thực hiện refresh.');
      return false;
    }

    _isRefreshing = true;

    try {
      // Tạo Dio instance riêng để tránh trigger interceptor
      final dio = Dio(
        BaseOptions(
          baseUrl: EnvironmentConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': currentRefreshToken},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final newAccessToken = response.data['data']['accessToken'] as String;
        final newRefreshToken = response.data['data']['refreshToken'] as String;

        await _storageService.saveToken(newAccessToken);
        await _storageService.saveRefreshToken(newRefreshToken);

        Logger.success('✅ Refresh token thành công.');
        return true;
      } else {
        Logger.error('❌ Refresh token thất bại: ${response.data}');
        await logout();
        return false;
      }
    } catch (e, stack) {
      Logger.error('💥 Lỗi khi refresh token', error: e, stackTrace: stack);
      await logout();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Đăng xuất và xóa dữ liệu xác thực
  Future<void> logout() async {
    try {
      // 1. Xóa tokens và user data
      await _storageService.clearAuthData();
      Logger.info('📝 Cleared auth data');

      // 2. Reset DI (xóa cached instances)
      await resetDependencies();
      Logger.info('🔄 Reset dependencies');

      // 3. Re-initialize DI (tạo instances mới)
      await configureDependencies();
      Logger.info('✅ Re-configured dependencies');

      Logger.success('🚪 Logout successful');
    } catch (e, stackTrace) {
      Logger.error('❌ Logout failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Kiểm tra xem user đã đăng nhập chưa
  bool get isLoggedIn {
    final token = _storageService.getToken();
    return token != null && token.isNotEmpty;
  }

  /// Lấy thông tin từ token
  Map<String, dynamic>? getTokenPayload() {
    final token = _storageService.getToken();
    if (token == null) return null;

    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      Logger.error('❌ Không thể decode token', error: e);
      return null;
    }
  }
}
