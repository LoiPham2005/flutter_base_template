import 'package:flutter_base_template/core/network/dio_client.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckAuthService {
  CheckAuthService(this._storageService, this._dioClient);
  final StorageService _storageService;
  final DioClient _dioClient;

  bool _isRefreshing = false;

  Future<void> checkAndRefreshToken() async {
    if (_isRefreshing) return;

    final accessToken = _storageService.getToken();
    final refreshToken = _storageService.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      Logger.warning('🔑 Tokens không tồn tại — bỏ qua refresh.');
      return;
    }

    try {
      final bool isAccessTokenExpired = JwtDecoder.isExpired(accessToken);
      final bool isRefreshTokenExpired = JwtDecoder.isExpired(refreshToken);

      if (isRefreshTokenExpired) {
        Logger.error('⏰ Refresh token đã hết hạn → Đăng xuất người dùng.');
        await logout();
        return;
      }

      if (isAccessTokenExpired) {
        Logger.info('♻️ Access token hết hạn → Bắt đầu refresh...');
        _isRefreshing = true;

        final response = await _dioClient.post(
          '/auth/refresh-token',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          final newAccessToken = response.data['data']['accessToken'];
          final newRefreshToken = response.data['data']['refreshToken'];

          await _storageService.saveToken(newAccessToken);
          await _storageService.saveRefreshToken(newRefreshToken);

          Logger.success('✅ Refresh token thành công.');
        } else {
          Logger.error('❌ Refresh token thất bại → Đăng xuất người dùng.');
          await logout();
        }
      } else {
        Logger.debug('🔒 Access token vẫn còn hiệu lực, không cần refresh.');
      }
    } catch (e, stack) {
      Logger.error('💥 Lỗi khi refresh token: $e', error: e, stackTrace: stack);
      await logout();
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> logout() async {
    await _storageService.clearAuthData();
    // TODO: Điều hướng người dùng về màn hình đăng nhập (nếu có)
    Logger.info('🚪 Người dùng đã đăng xuất và dữ liệu xác thực đã được xóa.');
  }
}
